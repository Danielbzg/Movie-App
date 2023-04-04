//
//  RepositoryNew.swift
//  Cartelerapp
//
//  Created by alp1 on 4/4/23.
//

import Foundation
import SwiftUI
/*
func moviesInTheatres(moviesRs: [Movie]) -> [Movie]{
    var movies = moviesRs
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=1c8d728618e95027b688d25724ea8fbb&language=es-ES!)") else {
        return movies
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
            movies = response.results
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }.resume()
    return movies
}

*/
