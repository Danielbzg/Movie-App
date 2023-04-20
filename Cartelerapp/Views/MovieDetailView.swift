//
//  MovieDetailView.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State private var movieCredits: Credits? = nil
    @State private var movieDetails: Details? = nil
    
    let movie: Movie
    @State var isFavorite: Bool
    @State var credits: String = ""
    
    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = movie.isFavorite
    }
    
    var body: some View {
        
        VStack {
            ScrollView(.vertical) {
                ZStack {
                    AsyncImage(url: RemoteImage.movieImage(path: movie.posterPath ?? "PosterDefault")) { image in image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .mask(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red, Color.red, Color.main.opacity(0)]), startPoint: .top, endPoint: .bottom))
                    } placeholder: {
                        ProgressView()
                    } //Fin imagen
                    
                    VStack{
                        Spacer()
                        Text(movie.title)
                            .foregroundColor(Color.title)
                            .font(Font.custom("SF Pro Normal", size: 28))
                    }
                    
                }
                .padding(.init(top: 10, leading: 2, bottom: 10, trailing: 2))
                
                HStack(alignment: .center, spacing: 5) {
                    
                    Text("Estreno \(movie.releaseDate)")
                    
                    Text(" · ")
                    
                    Text("Duración \(String(movieDetails?.duration ?? 0)) min.")
                    
                }
                .foregroundColor(Color.secondary)
                .frame(maxWidth: .infinity)
                .padding(.init(top: 10, leading: 2, bottom: 10, trailing: 2))
                
                //Géneros de la película
                HStack {
                    if let generos = movieDetails?.generos {
                        LazyVGrid(columns: [GridItem(.flexible(minimum:110), spacing: 3), GridItem(.flexible(minimum:150), spacing: 3)], content:  {
                            ForEach(generos, id: \.self) { genero in
                                ZStack{
                                    Rectangle()
                                        .fill(Color.backgroundButton)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.secondary, lineWidth: 0.5)
                                        )
                                        .cornerRadius(20)
                                    
                                    Text(genero)
                                        .padding(3)
                                        .foregroundColor(Color.secondary)
                                }
                            }
                        }
                                  )}
                                  }
                                    .frame(maxWidth: 120, alignment: .center)
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
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                                  
                                  
                                  VStack(alignment: .leading, spacing: 5) {
                            Text("Sinopsis")
                                .foregroundColor(Color.secondary)
                            
                            Text(movie.overview)
                                .foregroundColor(Color.longText)
                        }
                                    .padding(.init(top: 10, leading: 2, bottom: 10, trailing: 2))
                                  
                                  if let director = movieCredits?.director {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Director")
                                    .foregroundColor(Color(red: 121/255, green: 128/255, blue: 176/255))
                                Text(String(director.name))
                                    .foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.init(top: 10, leading: 2, bottom: 10, trailing: 2))
                        }
                                  
                                  VStack(alignment: .leading, spacing: 5) {
                            Text("Reparto")
                                .foregroundColor(Color.secondary)
                            
                            ScrollView(.horizontal){
                                HStack{
                                    if let mainCharacters = movieCredits?.mainCharacters {
                                        ForEach(mainCharacters) { character in
                                            VStack{
                                                AsyncImage(url: RemoteImage.movieImage(path: character.profilePath ?? "posterDefault")) { image in image.resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 85, height: 85)
                                                        .cornerRadius(25)
                                                } placeholder: {
                                                    ProgressView()
                                                } //Fin imagen
                                                
                                                Text(character.name)
                                                    .foregroundColor(Color.white)
                                                
                                                Text(character.character)
                                                    .foregroundColor(Color.gray)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: .infinity, height: 150, alignment: .trailing)
                        }
                                    .padding(.init(top: 10, leading: 2, bottom: 10, trailing: 2))
                                  }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
                                  }.background(Color.main)
                                    .onAppear {
                            loadCredits()
                            loadMovieDetails()
                        }
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
                                  
                                  func loadMovieDetails() {
                            Task {
                                do {
                                    let movieDetails = try await Dependencies.repository.moviesDetails(id: movie.id)
                                    print(movieDetails)
                                    self.movieDetails = movieDetails
                                } catch {
                                    print(error)
                                }
                            }
                        }
                                  }
