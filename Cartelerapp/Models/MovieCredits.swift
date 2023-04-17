//
//  MovieDetails.swift
//  Cartelerapp
//
//  Created by alp1 on 10/4/23.
//

import Foundation

struct MovieCredits: Codable, Identifiable {
    let id: Int
    let title: String
    let profilePath: String
    let name: String
    let job: String
}
