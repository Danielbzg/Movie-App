//
//  MovieDetails.swift
//  Cartelerapp
//
//  Created by Daniel Boza García on 10/4/23.
//

import Foundation

struct MovieCredits: Codable, Identifiable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable, Identifiable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int
    let character: String
    let creditId: String
    let order: Int
}

struct Crew: Codable, Identifiable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let creditId: String
    let department: String
    let job: String
}
