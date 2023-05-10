//
//  Repository.swift
//  Cartelerapp
//
//  Created by alp1 on 29/3/23.
//

import Foundation

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

    var favouritesMovies: [Int] {
        set { set(newValue, forKey: "favouritesMovies") }
        get { value(forKey: "favouritesMovies") as? [Int] ?? [] }
    }
    
    var pendingMovies: [Int] {
        set { set(newValue, forKey: "pendingMovies") }
        get { value(forKey: "pendingMovies") as? [Int] ?? [] }
    }
}

extension Movie {

    var isFavourite: Bool {
        Dependencies.repository.favouritesMovies().contains(id)
    }
    
    var isPending: Bool {
        Dependencies.repository.pendingMovies().contains(id)
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
        UserDefaults.standard.favouritesMovies
    }

    public func addMovieFavourite(_ movie: Movie) {
        var favouritesMovies = UserDefaults.standard.favouritesMovies
        favouritesMovies.append(movie.id)
        UserDefaults.standard.favouritesMovies = favouritesMovies
    }

    public func removeMovieFromFavourite(_ movie: Movie) {
        var favouritesMovies = UserDefaults.standard.favouritesMovies
        if let index = favouritesMovies.firstIndex(of: movie.id) {
            favouritesMovies.remove(at: index)
            UserDefaults.standard.favouritesMovies = favouritesMovies
        }
    }
    
    public func getFavouritesMovies() async throws -> [MovieDetails] {
        let favouritesMovies = UserDefaults.standard.favouritesMovies
        var moviesResult: [MovieDetails] = []
        for item in favouritesMovies {
            do {
                let movieDetails = try await moviesIndividual(id: item)
                moviesResult.append(movieDetails)
            } catch {
                // Manejo de errores aquí
                print("Error obteniendo detalles de la película: \(error)")
            }
        }
        return moviesResult
    }

    
    public func pendingMovies() -> [Int] {
        UserDefaults.standard.pendingMovies
    }
    
    public func addMoviePending(_ movie: Movie) {
        var pendingMovies = UserDefaults.standard.pendingMovies
        pendingMovies.append(movie.id)
        UserDefaults.standard.pendingMovies = pendingMovies
    }
    
    public func removeMovieFromPending(_ movie: Movie) {
        var pendingMovies = UserDefaults.standard.pendingMovies
        if let index = pendingMovies.firstIndex(of: movie.id) {
            pendingMovies.remove(at: index)
            UserDefaults.standard.pendingMovies = pendingMovies
        }
    }
    
    public func getPendingMovies() async throws -> [MovieDetails] {
        let pendingMovies = UserDefaults.standard.pendingMovies
        var moviesResult: [MovieDetails] = []
        for item in pendingMovies {
            do {
                let movieDetails = try await moviesIndividual(id: item)
                moviesResult.append(movieDetails)
            } catch {
                // Manejo de errores aquí
                print("Error obteniendo detalles de la película: \(error)")
            }
        }
        return moviesResult
    }
    
    public func movieDetailsToMovieIndividual(movieDetails: MovieDetails) -> Movie {
        var genresIds: [Int] = []
        for genre in movieDetails.genres {
            genresIds.append(genre.id)
        }
        let convertedMovie = Movie(id: movieDetails.id, title: movieDetails.title, posterPath: movieDetails.posterPath, overview: movieDetails.overview, releaseDate: movieDetails.releaseDate, voteAverage: movieDetails.voteAverage, genreIds: genresIds)
        return convertedMovie
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
    public func moviesIndividual(id: Int) async throws -> MovieDetails {
        let url: URL = urlMDetails(.movieIndividual, idMovie: id)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(MovieDetails.self, from: data)
        return result
    }
    
    //Función para consultar en la API los Detalles de la película
    public func moviesDetails(id: Int) async throws -> Details {
        let url: URL = urlMDetails(.movieIndividual, idMovie: id)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(MovieDetails.self, from: data)
        let duration = result.runtime
        var generos: [String] = []
        for genre in result.genres {
            let genreName = genre.name
            generos.append(genreName)
        }
        return .init(duration: duration, generos: generos)
    }
    
    //Función para consultar en la API los Créditos de la película
    public func moviesCredits(id: Int) async throws -> Credits {
        let url: URL = urlMCredits(.movieIndividual, idMovie: id)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let response = try await URLSession.shared.data(for: request)
        let data: Data = response.0
        let result = try decoder.decode(MovieCredits.self, from: data)

        let director = result.crew.first { $0.job.lowercased() == "director" }
        let mainCharacters = result.cast

        return .init(director: director, mainCharacters: mainCharacters)
    }
    
    //Función para buscar películas
    public func searchMovies(searchText: String) async throws -> [Movie] {
        guard let url: URL = urlSearchMovies(.movieSearch, text: searchText) else { return [] }
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
    private func urlSearchMovies(_ endpoint: MoviesAPI.Endpoint, text: String) -> URL? {
        var urlComponents = URLComponents(string: domain.rawValue + endpoint.rawValue)
        urlComponents?.queryItems = [
            .init(name: "api_key", value: apiKey.rawValue),
            .init(name: "query", value: text)
        ]
        return urlComponents?.url
    }
}

struct Credits {
    let director: Crew?
    let mainCharacters: [Cast]
}

struct Details {
    let duration: Int
    let generos: [String]
}
