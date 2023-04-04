//
//  Model.swift
//  Cartelerapp
//
//  Created by alp1 on 29/3/23.
//

import Foundation

struct Movie: Codable, Identifiable {
let id: Int
let title: String
let posterPath: String
let overview: String
let releaseDate: String
let voteAverage: Double
}
