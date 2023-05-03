//
//  MovieDetails.swift
//  Cartelerapp
//
//  Created by alp1 on 10/4/23.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genres]
    let homepage: String
    let id: Int
    //let imbdId: String?
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductCompany]
    let productionCountries: [ProductCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [SpokenLanguages]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

struct Genres: Codable, Identifiable {
    let id: Int
    let name: String
}

struct ProductCompany: Codable, Identifiable {
    let id: Int
    let logoPath: String?
    let name: String?
    let originCountry: String?
}

struct ProductCountry: Codable {
    let iso31661: String?
    let name: String?
}

struct SpokenLanguages: Codable {
    let englishName: String
    let iso6391: String
    let name: String
}
