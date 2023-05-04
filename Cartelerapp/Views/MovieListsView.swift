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
            VStack{
                Picker("", selection: $selected) {
                    Text("Favoritas").tag(0).foregroundColor(Color.dsTitle) .background(Color.dsBackgroundList)
                    Text("Pendientes").tag(1).foregroundColor(Color.dsTitle) .background(Color.dsBackgroundList)
                }.pickerStyle(.segmented)
                
                
            }
            if selected == 0{
                ScrollView(.vertical){
                    ForEach(moviesFavourites) {movieItem in
                        VStack{
                            NavigationLink {
                                MovieDetailView(movie: Dependencies.repository.movieDetailsToMovieIndividual(movieDetails: movieItem))
                                
                            } label: {
                                HStack(spacing: 16){
                                    AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(12)
                                        
                                    } placeholder: {
                                        
                                        ProgressView()
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 4){
                                        Text(movieItem.title)
                                            .font(.callout.bold())
                                            .foregroundColor(Color.dsTitle)
                                        HStack{
                                            Image(systemName: "film")
                                                .foregroundColor(Color.dsSecondary)
                                            Text(String(movieItem.formattedReleaseDate ?? ""))
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
                                    .frame(width: 240, height: 86, alignment: .leading)
                                }
                                .padding(8)
                            }
                            
                        }
                        //.padding(8)
                        .background(Color.dsBackgroundList)
                        .cornerRadius(12)
                    }
                }.padding(8)
            }
            if selected == 1{
                ScrollView(.vertical){
                    ForEach(moviesPending) {movieItem in
                        VStack{
                            NavigationLink {
                                
                                MovieDetailView(movie: Dependencies.repository.movieDetailsToMovieIndividual(movieDetails: movieItem))
                                
                            } label: {
                                HStack(spacing: 16){
                                    AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(12)
                                        
                                    } placeholder: {
                                        
                                        ProgressView()
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 4){
                                        Text(movieItem.title)
                                            .font(.callout.bold())
                                            .foregroundColor(Color.dsTitle)
                                        HStack{
                                            Image(systemName: "film")
                                                .foregroundColor(Color.dsSecondary)
                                            Text(String(movieItem.formattedReleaseDate ?? ""))
                                                .font(.footnote)
                                                .foregroundColor(Color.dsSecondary)
                                        }
                                        HStack{
                                            Image(systemName: "clock").foregroundColor(Color.dsSecondary)
                                            Text(String(movieItem.runtime)  + " min.")
                                                .font(.footnote)
                                                .foregroundColor(Color.dsSecondary)
                                        }
                                        
                                        
                                        
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 240, height: 86, alignment: .leading)
                                }
                                .padding(8)
                                
                            }
                        }
                        //.padding(8)
                        .background(Color.dsBackgroundList)
                        .cornerRadius(12)
                    }
                }.padding(8)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.dsMain)
            .onAppear { LoadFavouritesMovies()
                LoadPendingMovies()
            }
            .navigationTitle("Mis listas")
    }
    
    
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
