//
//  Repository.swift
//  Cartelerapp
//
//  Created by alp1 on 29/3/23.
//

import Foundation
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    @State var movies: [Movie] = []
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
                
                DispatchQueue.main.async { [self] in
                    self.movies = response.results
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }

}

struct Response: Codable {
let results: [Movie]
}
