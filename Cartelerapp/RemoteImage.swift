//
//  RemoteImage.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import Foundation

class RemoteImage {

    private static let movieURL: String = "https://image.tmdb.org"

    static func movieImage(path: String, width: Int = 500) -> URL {
        URL(string: movieURL + "/t/p/w\(width)" + path)!
    }
}
