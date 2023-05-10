//
//  Cartelera.swift
//  Cartelerapp
//
//  Created by alp1 on 31/3/23.
//

import SwiftUI

struct MovieListsView: View {
    
    @State private var selected = 0
    @State private var moviesFavourites: [MovieDetails] = []
    @State private var moviesPending: [MovieDetails] = []
    
    var body: some View {
        VStack{
            HStack{
                Text("Mis Listas")
            }.foregroundColor(Color.dsTitle)
                .font(.title)
                .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .top)
                .padding(0)
            VStack {
                Picker("", selection: $selected) {
                    Text("Favoritas").tag(0)
                    Text("Pendientes").tag(1)
                }
                .pickerStyle(.segmented)
                .accentColor(.blue)
                .cornerRadius(8)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .background(Color.dsBackgroundList) // color de fondo del picker completo
                .foregroundColor(.white) // color de texto del picker completo
                
                if selected == 0{
                    favourites
                }
                if selected == 1{
                    pending
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.dsMain)
                .onAppear { LoadFavouritesMovies()
                    LoadPendingMovies()
                }
                .navigationBarHidden(true)
        }
            .background(Color.dsMain)
        
        
    }
    var favourites: some View {
        ScrollView(.vertical){
            ForEach(moviesFavourites) {movieItem in
                VStack{
                    NavigationLink {
                        MovieDetailView(movie: Dependencies.repository.movieDetailsToMovieIndividual(movieDetails: movieItem))
                        
                    } label: {
                        HStack(spacing: 16){
                            VStack(alignment: .center){
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(12)
                                    
                                } placeholder: {
                                    
                                    ProgressView()
                                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
                                    
                                }
                            }
                            .frame(minWidth:32, maxWidth: 152, minHeight:135.05, maxHeight: 255.05)
                            .cornerRadius(8)
                            
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(movieItem.title)
                                    .font(.callout.bold())
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color.dsTitle)
                                HStack{
                                    Image(systemName: "film")
                                        .foregroundColor(Color.dsSecondary)
                                    Text(String(movieItem.formattedReleaseDate ?? "N/A"))
                                        .font(.footnote)
                                        .foregroundColor(Color.dsSecondary)
                                }
                                HStack{
                                    Image(systemName: "clock")
                                        .foregroundColor(Color.dsSecondary)
                                    Text(String(movieItem.runtime) + " min.")
                                        .font(.footnote)
                                        .foregroundColor(Color.dsSecondary)
                                }
                                
                            }
                            .foregroundColor(.white)
                            .frame(minWidth: 200, minHeight: 86, alignment: .leading)
                        }.padding(8)
                    }
                    
                }
                .padding(8)
                .background(Color.dsBackgroundList)
                .cornerRadius(12)
            }
        }.padding(8)
    }
    
    var pending: some View {
        ScrollView(.vertical){
            ForEach(moviesPending) {movieItem in
                VStack{
                    NavigationLink {
                        MovieDetailView(movie: Dependencies.repository.movieDetailsToMovieIndividual(movieDetails: movieItem))
                        
                    } label: {
                        HStack(spacing: 16){
                            VStack(alignment: .center){
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(12)
                                    
                                } placeholder: {
                                    
                                    ProgressView()
                                    
                                }
                            }
                            .frame(minWidth:32, minHeight:135.05)
                            .cornerRadius(8)
                            //.padding(8)
                            
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(movieItem.title)
                                    .font(.callout.bold())
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color.dsTitle)
                                HStack{
                                    Image(systemName: "film")
                                        .foregroundColor(Color.dsSecondary)
                                    Text(String(movieItem.formattedReleaseDate ?? "N/A"))
                                        .font(.footnote)
                                        .foregroundColor(Color.dsSecondary)
                                }
                                HStack{
                                    Image(systemName: "clock")
                                        .foregroundColor(Color.dsSecondary)
                                    Text(String(movieItem.runtime) + " min.")
                                        .font(.footnote)
                                        .foregroundColor(Color.dsSecondary)
                                }
                                
                            }
                            .foregroundColor(.white)
                            .frame(minWidth: 200, minHeight: 86, alignment: .leading)
                        }.padding(8)
                    }
                    
                }
                .padding(8)
                .background(Color.dsBackgroundList)
                .cornerRadius(12)
            }
        }.padding(8)
    }
    //ForEach(moviesPending) {movieItem in
    func LoadFavouritesMovies() {
        Task {
            do {
                let movies = try await Dependencies.repository.getFavouritesMovies()
                print(movies)
                self.moviesFavourites = movies
            } catch {
                print(error)
            }
        }
    }
    func LoadPendingMovies() {
        Task {
            do {
                let movies = try await Dependencies.repository.getPendingMovies()
                print(movies)
                self.moviesPending = movies
            } catch {
                print(error)
            }
        }
    }
}

struct MovieListsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListsView()
    }
}
