//
//  MovieDetail+Extras.swift
//  Cartelerapp
//
//  Created by Daniel Boza García on 10/5/23.
//

import Foundation

extension MovieDetails {
//Creación de una "función" para pasar una Moviedetails a un tipo Movie
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
