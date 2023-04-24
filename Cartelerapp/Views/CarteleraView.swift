//
//  Cartelera.swift
//  Cartelerapp
//
//  Created by alp1 on 31/3/23.
//

import SwiftUI

struct CarteleraView: View {

    @State private var movies: [Movie] = []

    var body: some View {

        ScrollView(.vertical) {

            LazyVGrid(columns: [GridItem(.flexible(minimum:110), spacing: 1), GridItem(.flexible(minimum:150), spacing: 0)], content:  {

                ForEach(movies) { movieItem in

                    VStack{

                        NavigationLink {

                            MovieDetailView(movie: movieItem)

                        } label: {

                            VStack(spacing: 0.2){
                                
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath ?? "PosterDefault.jpg")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(25)

                                } placeholder: {

                                    ProgressView()

                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .cornerRadius(8)
                                
                                Text(movieItem.title)
                                    .frame(width: 120, height: 40, alignment: .init(horizontal: .leading, vertical: .center))
                                    .font(.system(size: 15, weight: .bold, design: .default))
                                    .foregroundColor(Color.longText)
                                
                                Text(Dependencies.repository.convertFormatDate(dateInsert: movieItem.releaseDate))
                                    .frame(width: 120, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(Color.secondary)
                                    
                                
                            }
                            .multilineTextAlignment(.leading)
                            .frame(width: 150, height: 275)
                        }
                    }.padding(.init(top:3, leading:2, bottom:3, trailing: 2))
                        
                }
            })//Espacios de los Posters y títulos
        }
        .background(Color.main)
        .onAppear {moviesInTheatres()}
        .navigationTitle("CARTELERAPP")
    }

    
    func moviesInTheatres() {
        Task {
            do {
                let movies = try await Dependencies.repository.moviesInTheatres()
                print(movies)
                self.movies = movies
            } catch {
                print(error)
            }
        }
    }
}

struct Cartelera_Previews: PreviewProvider {
    static var previews: some View {
        CarteleraView()
    }
}
