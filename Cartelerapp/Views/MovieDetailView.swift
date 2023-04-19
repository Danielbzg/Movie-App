//
//  MovieDetailView.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State private var movieCredits: Credits? = nil
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
                ZStack {
                    AsyncImage(url: RemoteImage.movieImage(path: movie.posterPath ?? "PosterDefault.jpg")) { image in image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .mask(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red, Color.red, Color.blue.opacity(0)]), startPoint: .top, endPoint: .bottom))
                    } placeholder: {
                        ProgressView()
                    } //Fin imagen
                    
                    VStack{
                        Spacer()
                        Text(movie.title)
                            .foregroundColor(.white)
                            .font(.custom("SF Pro Display", size: 28))
                    }
                    
                }
                
                HStack {
                    HStack {
                        Text("Estreno: ")
                        
                        Text(movie.releaseDate)
                    }
                    Spacer()
                    Text("·")
                    Spacer()
                    HStack {
                        
                        Text("Duración: ")
                        Text(String(movie.voteAverage))
                        
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                
                //Géneros de la película
                HStack {
                    ZStack{
                        Rectangle()
                            .background(.blue)
                            .cornerRadius(8)
                    Text(String(movie.genreIds[0]))
                            .padding(3)
                            .foregroundColor(.gray)
                        }
                    
                    ZStack{
                        Rectangle()
                            .background(.blue)
                            .cornerRadius(8)
                    Text(String(movie.genreIds[1]))
                            .padding(3)
                            .foregroundColor(.gray)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                
                
                //Botones Favoritos - Pendientes...
                HStack{
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
                
                if let director = movieCredits?.director {
                    HStack {
                        Text("Director: ")
                        Text(String(director.name))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                }
                
                VStack{
                    Text("Reparto")
                    
                }
                
            }
        }
        .background(LinearGradient(colors: [Color(red: 63/255, green: 132/255, blue: 229/255), Color(red: 24/255, green: 48/255, blue: 89/255)], startPoint: .top, endPoint: .center))
        .onAppear { loadCredits() }
    }
    
    func loadCredits() {
        
        Task {
            do {
                let movieCredits = try await Dependencies.repository.moviesCredits(id: movie.id)
                print(movieCredits)
                self.movieCredits = movieCredits
            } catch {
                print(error)
            }
        }
    }
}

