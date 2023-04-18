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
        case movieIndividual = "/3/movie/"
        case moviesInTheatres = "/3/movie/now_playing"
        case movieSearch = "/3/search/movie"
    }
    
}

extension UserDefaults {

    var favoritesMovies: [Int] {
        set { set(newValue, forKey: "favoritesMovies") }
        get { value(forKey: "favoritesMovies") as? [Int] ?? [] }
    }
}

extension Movie {

    var isFavorite: Bool {
        Dependencies.repository.favouritesMovies().contains(id)
    }
}


class Repository {

    private var moviesFavourite: [Movie] = []

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

    private func setMoviesFavourites(newMovies: [Movie]) {
        self.moviesFavourite = newMovies
    }
    
    //Función para la creación de url y consultar películas en cartelera
    private func url(_ endpoint: MoviesAPI.Endpoint) -> URL {
        URL(string: domain.rawValue + endpoint.rawValue + "?api_key=\(apiKey.rawValue)&language=\(Locale.current.identifier)")!
    }

    //Getter, setter y añadir película a favorita
    public func favouritesMovies() -> [Int] {
        UserDefaults.standard.favoritesMovies
    }

    public func addMovieFavourite(_ movie: Movie) {
        var favoritesMovies = UserDefaults.standard.favoritesMovies
        favoritesMovies.append(movie.id)
        UserDefaults.standard.favoritesMovies = favoritesMovies
    }

    public func removeMovieFromFavourite(_ movie: Movie) {
        var favoritesMovies = UserDefaults.standard.favoritesMovies
        if let index = favoritesMovies.firstIndex(of: movie.id) {
            favoritesMovies.remove(at: index)
            UserDefaults.standard.favoritesMovies = favoritesMovies
        }
    }

    public func moviesInTheatres() async throws -> [Movie] {
        let url: URL = url(.moviesInTheatres)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(ResponseMovies.self, from: data)
        return result.results
    }
    
    //Función para consultar en la API los Detalles de la película
    public func moviesDetails(id: Int) async throws -> MovieDetails {
        let url: URL = urlMDetails(.movieIndividual, idMovie: id)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(ResponseMoviesDetails.self, from: data)
        return result.results
    }
    
    //Función para consultar en la API los Créditos de la película
    public func moviesCredits(id: Int) async throws -> MovieCredits {
        let url: URL = urlMCredits(.movieIndividual, idMovie: id)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(ResponseMoviesCredits.self, from: data)
        return result.results
    }
    
    //Función para buscar películas
    public func searchMovies(searchText: String) async throws -> [Movie] {
        let url: URL = urlSearchMovies(.movieSearch, text: searchText)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(ResponseMovies.self, from: data)
        return result.results
    }
    
    //Función para la creación de la url de los Detalles de la película
    private func urlMDetails(_ endpoint: MoviesAPI.Endpoint, idMovie: Int) -> URL {
        URL(string: domain.rawValue + endpoint.rawValue + "\(idMovie)" + "?api_key=\(apiKey.rawValue)&language=\(Locale.current.identifier)")!
    }
    
    //Función para creación de la url para consultar los Créditos de la película
    private func urlMCredits(_ endpoint: MoviesAPI.Endpoint, idMovie: Int) -> URL {
        URL(string: domain.rawValue + endpoint.rawValue + "\(idMovie)" + "/credits?api_key=\(apiKey.rawValue)&language=\(Locale.current.identifier)")!
    }
    
    //Función para creación de url del buscador
    private func urlSearchMovies(_ endpoint: MoviesAPI.Endpoint, text: String) -> URL {
        URL(string: domain.rawValue + endpoint.rawValue + "?api_key=\(apiKey.rawValue)&query=\(text)")!
    }
    
    //.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed
}
