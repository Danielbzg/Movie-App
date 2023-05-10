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
            
            LazyVGrid(columns: [GridItem(.fixed(163), spacing:17), GridItem(.fixed(163), spacing: 17)], content:  {
                
                ForEach(movies) { movieItem in
                    
                    VStack{
                        
                        NavigationLink {
                            
                            MovieDetailView(movie: movieItem)
                            
                        } label: {
                            
                            VStack(spacing: 8){
                                
                                AsyncImage(url: RemoteImage.movieImage(path: movieItem.posterPath ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 163, height: 241)
                                        .cornerRadius(25)
                                    
                                } placeholder: {
                                    
                                    ProgressView()
                                    
                                }
                                
                                VStack(spacing: 4){
                                    Text(movieItem.title)
                                        .frame(maxWidth: 120, maxHeight: 40, alignment: .init(horizontal: .leading, vertical: .top))
                                        .font(.subheadline.bold())
                                        .foregroundColor(Color.dsLongText)
                                    
                                    Text("\(movieItem.formattedReleaseDate ?? "")")
                                        .frame(width: 120, height: 20, alignment: .init(horizontal: .leading, vertical: .top))
                                        .font(.footnote)
                                        .foregroundColor(Color.dsSecondary)
                                }
                                .multilineTextAlignment(.leading)
                            }
                        }.frame(width: 163, height: 311, alignment: .init(horizontal: .leading, vertical: .top))
                            //.background(.yellow)
                    }
                }
            })
        }
        .background(Color.dsMain)
        .onAppear {moviesInTheatres()}
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("Logo")
            }
            
        }
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
        NavigationView {
            CarteleraView()
        }
    }
}
