//
//  MovieDetailView.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie

    var body: some View {

        VStack {
            AsyncImage(url: RemoteImage.movieImage(path: movie.posterPath)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }

            Text(movie.title)
        }

    }
}
