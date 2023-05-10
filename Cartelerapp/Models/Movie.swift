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
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let genreIds: [Int]
}

extension Movie {

    var apiReleaseDate: Date? {
        DateFormatter.apiFormatter.date(from: releaseDate)
    }

    var formattedReleaseDate: String? {
        guard let apiReleaseDate = apiReleaseDate else { return nil }
        return DateFormatter.appFormatter.string(from: apiReleaseDate)
    }
}
