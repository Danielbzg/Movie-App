//
//  MovieDetails.swift
//  Cartelerapp
//
//  Created by alp1 on 10/4/23.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let genres: [String]
}
