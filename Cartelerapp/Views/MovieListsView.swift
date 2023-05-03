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
    @State private var moviesPending: [Movie] = []

    var body: some View {
        VStack{
            VStack{
                Picker("", selection: $selected) {
                    Text("Favoritas").tag(0)
                    Text("Pendientes").tag(1)
                }.pickerStyle(.segmented)
                
            }
            if selected == 0{
                ForEach(moviesFavourites) {item in
                    VStack{
                        Text(item.title)
                            .foregroundColor(.white)
                    }
                }
            }
            if selected == 1{
                Text("Listado de pendientes")
                    .foregroundColor(.white)
            }
            
            
        }
        .background(Color.main)
        .onAppear { LoadFavouritesMovies() }
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
}

struct MovieListsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListsView()
    }
}
