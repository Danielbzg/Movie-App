//
//  MovieDetailView.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie
    @State var isFavorite: Bool
    @State var credits: String = ""

    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = movie.isFavorite
    }

    var body: some View {

        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack {
                    
                    Text(movie.title)
                    AsyncImage(url: RemoteImage.movieImage(path: movie.posterPath ?? "PosterDefault.jpg")) { image in image.resizable()
                                            .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                    }
                }
                
                HStack {
                    Text("Estreno: ")
                    
                    Text(movie.releaseDate)
                    
                    Spacer()
                    
                    Button(action: {
                        if isFavorite {
                            Dependencies.repository.removeMovieFromFavourite(movie)
                        } else {
                            Dependencies.repository.addMovieFavourite(movie)
                        }
                        isFavorite.toggle()

                        print("Película a añadir: \(movie)")
                    }, label: {
                        HStack{
                            
                            Image(isFavorite ? "starFav" : "starAdd")
                                .aspectRatio(contentMode: .fit)
                            
                            Text(isFavorite ? "Eliminar" : "Añadir")
                    
                        } .padding([.leading, .trailing], 5)
                        
                    })
                        .frame(minWidth: 30, minHeight: 45)
                        .background(.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        
                    Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                
                HStack {
                    
                    Text("Valoración: ")
                    Text(String(movie.voteAverage))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                
                HStack {
                    
                    Text("Género: ")
                    Text(String(movie.genreIds[0]))
                    
                    Button(action: {
                        print("Las películas favoritas son: \(Dependencies.repository.favouritesMovies())")
                    }, label: {
                        Text("Ver favoritas")
                            .padding(3)
                    })
                        .frame(minWidth: 50)
                        .background(.orange)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                
                VStack{
                        
                    Text("Sinopsis")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Courier", fixedSize: 20))
                    
                    Text(movie.overview)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
            }
        }
        .background(LinearGradient(colors: [Color(red: 63/255, green: 132/255, blue: 229/255), Color(red: 24/255, green: 48/255, blue: 89/255)], startPoint: .top, endPoint: .center))
    }
}

