//
//  Response.swift
//  Cartelerapp
//
//  Created by alp1 on 4/4/23.
//

import Foundation

struct ResponseMovies: Codable {
    let results: [Movie]
}

struct ResponseMoviesDetails: Codable {
    let results: MovieDetails
}
