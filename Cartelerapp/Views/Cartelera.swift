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
                    VStack {
                        ForEach(movies) {
                            TheatresMovieItem in ZStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(TheatresMovieItem.posterPath)")!) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }   .frame(width: 140, height: 200)
                                    .cornerRadius(8)
                                VStack{
                                    Spacer()
                                Text(TheatresMovieItem.title)
                                    .frame(width: 140, height: 50, alignment: .center)
                                    .padding(0.2)
                                    .font(.headline)
                                    .background(Color.gray)
                                    .opacity(0.5)
                                    .foregroundColor(Color.white)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 800, alignment: .center)
            .background(Color.indigo)
            .onAppear(perform: moviesInTheatres)
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
    }
    
    func moviesInTheatres() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=1c8d728618e95027b688d25724ea8fbb&language=es-ES!)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(Response.self, from: data)
                
                DispatchQueue.main.async {
                    self.movies = response.results
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
}

struct Response: Codable {
    let results: [Movie]
}

struct Cartelera_Previews: PreviewProvider {
    static var previews: some View {
        Cartelera()
    }
}
