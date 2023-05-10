//
//  MovieDetail+Extras.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/5/23.
//

import Foundation

extension MovieDetails {

    var toMovie: Movie {
        .init(
            id: id,
            title: title,
            posterPath: posterPath,
            overview: overview,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            genreIds: genres.map { $0.id }
        )
    }
}
