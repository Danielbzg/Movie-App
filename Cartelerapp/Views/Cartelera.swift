//
//  Cartelera.swift
//  Cartelerapp
//
//  Created by alp1 on 31/3/23.
//

import SwiftUI

struct Cartelera: View {

    @State private var movies: [Movie] = []

    var body: some View {

        ScrollView(.vertical) {

            LazyVGrid(columns: [GridItem(.flexible(minimum:90), spacing: 5), GridItem(.flexible(minimum:150), spacing: 0)], content:  {

                ForEach(movies) { MovieItem in

                    VStack{

                        NavigationLink {

                            MovieDetailView(movie: MovieItem)

                        } label: {

                            ZStack{

                                AsyncImage(url: RemoteImage.movieImage(path: MovieItem.posterPath)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)

                                } placeholder: {

                                    ProgressView()

                                }
                                .frame(width: .infinity, height: 200)
                                .cornerRadius(8)

                                VStack{
                                    Spacer()
                                    Text(MovieItem.title)
                                        .frame(width: 90, height: 50, alignment: .center)
                                        .padding(0.2)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .background(Color.gray)
                                        .opacity(0.5)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                    }
                }
            })//Espacios de los Posters y títulos
        }
        .background(LinearGradient(colors: [Color.orange, Color.red], startPoint: .top, endPoint: .center))
        .onAppear { moviesInTheatres() }
        .navigationTitle("CARTELERAAPP")
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
        Cartelera()
    }
}
