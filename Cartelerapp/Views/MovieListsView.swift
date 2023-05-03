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
                    Text("Favoritas").tag(0)
                    Text("Pendientes").tag(1)
                }.pickerStyle(.segmented)
                
            }
            if selected == 0{
                ScrollView(.vertical){
                    ForEach(moviesFavourites) {movieItem in
                        VStack{
                            HStack{
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(25)
                                    
                                } placeholder: {
                                    
                                    ProgressView()
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .cornerRadius(8)
                                
                                VStack{
                                    Text(movieItem.title)
                                    Text(String(movieItem.releaseDate))
                                    Text(String(movieItem.runtime))
                                        
                                }.foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            if selected == 1{
                ScrollView(.vertical){
                    ForEach(moviesPending) {movieItem in
                        VStack{
                            HStack{
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(25)
                                    
                                } placeholder: {
                                    
                                    ProgressView()
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .cornerRadius(8)
                                
                                VStack{
                                    Text(movieItem.title)
                                    Text(String(movieItem.releaseDate))
                                    Text(String(movieItem.runtime))
                                }.foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.main)
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
