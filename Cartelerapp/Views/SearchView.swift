//  SearchView.swift
//  Cartelerapp
//
//  Created by Daniel Boza García on 17/4/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var movies: [MovieSR] = []
    @State private var moviesDuration: [Int: Int] = [:]
    
    var body: some View {
        VStack {
            searchBarView()
            
            ScrollView(.vertical) {
                movieListView()
            }
            .padding(8)
        }
        .background(Color.dsMain)
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("Logo")
            }
        }
    }
    
    func searchBarView() -> some View {
        HStack {
            TextField("Busca la película", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                searchMoviesView()
            }) {
                Image(systemName: "magnifyingglass")
                    .padding(.horizontal)
            }
        }
        .padding()
    }
    
    //Extracto de código para generar las listas
    func movieListView() -> some View {
        ForEach(movies) { movieItem in
            VStack {
                NavigationLink(destination: MovieDetailView(movie: Dependencies.repository.movieSearchResultToMovieIndividual(movieSearch: movieItem))) {
                    HStack(spacing: 16) {
                        moviePosterView(movieItem: movieItem)
                        movieDetailsView(movieItem: movieItem)
                    }
                    .padding(8)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .padding(8)
            .background(Color.dsBackgroundList)
            .cornerRadius(12)
        }
    }
    
    //Extracto de código para cargar imagen póster de la película
    func moviePosterView(movieItem: MovieSR) -> some View {
        VStack(alignment: .center) {
            AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            }
        }
        .frame(minWidth: 32, maxWidth: 152, minHeight: 135.05, maxHeight: 255.05)
        .cornerRadius(8)
    }
    
    //Extracto de código para crear parte de la vista de detalles de la película
    //Como son título, fecha de estreno, duración y sus respectivos logos acompañantes
    func movieDetailsView(movieItem: MovieSR) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(movieItem.title)
                .font(.callout.bold())
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.dsTitle)
            
            //Fecha de estreno e icono de rollo de película
            HStack {
                Image(systemName: "film")
                    .foregroundColor(Color.dsSecondary)
                Text(String(movieItem.formattedReleaseDate ?? "N/A"))
                    .font(.footnote)
                    .foregroundColor(Color.dsSecondary)
            }
            if let duration = moviesDuration[movieItem.id] {
                //duración e icono de reloj
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(Color.dsSecondary)
                    Text(String(duration) + " min.")
                        .font(.footnote)
                        .foregroundColor(Color.dsSecondary)
                }
            }
        }
        .task { await loadDetails(id: movieItem.id) }
        .foregroundColor(.white)
        .frame(minWidth: 200, minHeight: 86, alignment: .leading)
    }
    
    //Función para buscar película con el buscador
    func searchMoviesView() {
        Task {
            do {
                let movies = try await Dependencies.repository.searchMovies(searchText: self.searchText)
                self.moviesDuration = [:]
                self.movies = movies
            } catch {
                print(error)
            }
        }
    }
    
    //Función para usar la función de cargar detalles en la vista.
    func loadDetails(id: Int) async {
        do {
            let detailsSearch = try await Dependencies.repository.moviesDetails(id: id)
            self.moviesDuration[id] = detailsSearch.duration
            print(moviesDuration)
        } catch {
            print(error)
        }
    }
}

//Vista previa de la vista para usar en XCode
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
