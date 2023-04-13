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

                            VStack(spacing: 2){
                                Text(String(movieItem.releaseDate))
                                    .frame(width: 140, height: 20, alignment: .center)
                                    .padding(0.2)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8)
                                
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath)) { image in
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
                }
            })//Espacios de los Posters y títulos
        }
        .background(LinearGradient(colors: [Color(red: 63/255, green: 132/255, blue: 229/255), Color(red: 24/255, green: 48/255, blue: 89/255)], startPoint: .top, endPoint: .center))
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
