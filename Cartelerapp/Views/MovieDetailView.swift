//
//  MovieDetailView.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie

    var body: some View {

        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack {
                    
                    Text(movie.title)
                    AsyncImage(url: RemoteImage.movieImage(path: movie.posterPath)) { image in image.resizable()
                                            .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                    }
                }
                
                HStack {
                    Text("Estreno: ")
                    Text(movie.releaseDate)
                    
                    Button(action: {
                        Dependencies.repository.addMovieFavourite(movieToInsert: movie)
                    }, label: {
                        Text("Añadir a Favoritas")
                    })
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

