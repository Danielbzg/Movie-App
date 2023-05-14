//
//  Response.swift
//  Cartelerapp
//
//  Created by Daniel Boza García on 4/4/23.
//

import Foundation

struct ResponseMovies: Codable {
    let results: [Movie]
}

struct ResponseMoviesSearchResult: Codable {
    let results: [MovieSR]
}
