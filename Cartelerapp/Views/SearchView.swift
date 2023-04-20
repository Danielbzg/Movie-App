//
//  SearchView.swift
//  Cartelerapp
//
//  Created by alp1 on 17/4/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var movies: [Movie] = []
    
    var body: some View {
        VStack{
            //Creación de la barra de búsqueda
            HStack {
                TextField("Busca la película", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    print("Valor de la variable text en la struct del SearchBar: \(searchText)")
                    searchMoviesView()
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal)
                }
            }
            .padding()
            ScrollView(.vertical) {
                
                ForEach(movies) { movieItem in
                    VStack {
                        
                        NavigationLink {
                            
                            MovieDetailView(movie: movieItem)
                            
                        } label: {
                            
                            VStack(spacing: 2){
                                Text(String(movieItem.releaseDate))
                                    .frame(width: 140, height: 20, alignment: .center)
                                    .padding(0.2)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8)
                                
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath ?? "PosterDefault")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    
                                    ProgressView()
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .cornerRadius(8)
                                
                                Text(movieItem.title)
                                    .frame(width: 140, height: 50, alignment: .center)
                                    .padding(0.2)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8)
                                
                            }
                            .frame(width: 150, height: 275, alignment: .trailing)
                            .background(Color(red: 21/255, green: 21/255, blue: 85/255).opacity(0.8))
                            .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("Buscador")
    }
    
    func searchMoviesView() {
        Task {
            do {
                print("El texto a buscar es \(self.searchText)")
                let movies = try await Dependencies.repository.searchMovies(searchText: self.searchText)
                print(movies)
                self.movies = movies
            } catch {
                print(error)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

