//
//  MovieSearchResult.swift
//  Cartelerapp
//
//  Created by alp1 on 9/5/23.
//

import Foundation

struct MovieSearchResult: Codable {
    let page: Int
    let results: [MovieSR]
}

struct MovieSR: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension MovieSR {

    var apiReleaseDate: Date? {
        DateFormatter.apiFormatter.date(from: releaseDate)
    }

    var formattedReleaseDate: String? {
        guard let apiReleaseDate = apiReleaseDate else { return nil }
        return DateFormatter.appFormatter.string(from: apiReleaseDate)
    }
}
