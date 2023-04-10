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
        VStack {
            Text("CARTELERAPP")
                .frame(minWidth: 10, maxWidth: .infinity, minHeight: 10, maxHeight: 60, alignment: .center)
                .background(Color.mint)
                .font(.largeTitle)
             
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible(minimum:90), spacing: 5), GridItem(.flexible(minimum:150), spacing: 0)], content:  {
                        ForEach(movies) {
                            MovieItem in VStack{
                                ZStack{
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(MovieItem.posterPath)")!) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            ProgressView()
                                        }   .frame(width: .infinity, height: 200)
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
                    })//Espacios de los Posters y títulos
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 800, alignment: .center)
            .background(Color.indigo)

            HStack {
                //Botón 1
                Button(action: {
                    print("Prueba 1")
                }, label: {
                    Text("Botón 1")
                })
                    .padding()
                    .background(Color.orange)
                
                Spacer()
                
                //Botón 2
                Button(action: {
                    print("Prueba 2")
                }, label: {
                    Text("Botón 2")
                })
                    .padding()
                    .background(Color.orange)
                
                Spacer()
                
                //Botón 3
                Button(action: {
                    print("Prueba 3")
                }, label: {
                    Text("Botón 3")
                })
                    .padding()
                    .background(Color.orange)
            }
            .background(Color.mint)
        } //Fin VStack principal
        .background(LinearGradient(colors: [Color.orange, Color.red], startPoint: .top, endPoint: .center))
        .onAppear { moviesInTheatres() }
    }

    
    func moviesInTheatres() {

        Task {
            do {
                let movies = try await Repository().moviesInTheatres()
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
