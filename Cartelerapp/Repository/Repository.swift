//
//  Repository.swift
//  Cartelerapp
//
//  Created by alp1 on 29/3/23.
//

import Foundation
import SwiftUI

enum MoviesAPI {

    enum Domain: String {
        case production = "https://api.themoviedb.org"
    }

    enum APIKey: String {
        case production = "1c8d728618e95027b688d25724ea8fbb"
    }

    enum Endpoint: String {
        case movies = "/3/movie/now_playing"
    }
}


class Repository {

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    let domain: MoviesAPI.Domain
    let apiKey: MoviesAPI.APIKey

    init(domain: MoviesAPI.Domain = .production, apiKey: MoviesAPI.APIKey = .production) {
        self.domain = domain
        self.apiKey = apiKey
    }

    private func url(_ endpoint: MoviesAPI.Endpoint) -> URL {
        URL(string: domain.rawValue + endpoint.rawValue + "?api_key=\(apiKey.rawValue)&language=\(Locale.current.identifier)")!
    }

    func moviesInTheatres() async throws -> [Movie] {
        let url: URL = url(.movies)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"        
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(Response.self, from: data)
        return result.results
    }
}
