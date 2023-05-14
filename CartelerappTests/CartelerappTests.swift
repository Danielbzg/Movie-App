import XCTest
@testable import Movie_App

class Movie_AppTests: XCTestCase {
    //Se inicializa el repositorio para usarlo en todas las pruebas
    var repository: Repository!
    
    override func setUpWithError() throws {
        repository = Repository()
    }
    
    override func tearDownWithError() throws {
        // Código de limpieza (si es necesario) después de cada prueba
    }
    
    func testExample() throws {
        // Código de prueba
    }
    
    func testPerformanceExample() throws {
        // Código de prueba de rendimiento
    }
    
    func testMoviesInthreates() async throws {
        let movies = try await repository.moviesInTheatres()
        XCTAssertNotNil(movies)
    }
    
    func testFavouritesMovies() {
        let movies = repository.favouritesMovies()
        XCTAssertNotNil(movies)
    }
    
    func testAddMovieToFavourites() {
        let movie = Movie(id: 502356, title: "The Super Mario Bros. Movie", posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", releaseDate: "2023-04-05", voteAverage: 7.5, genreIds: [16, 12, 10751, 14, 35])
        repository.addMovieFavourite(movie)
        
        let favouritesMovies = repository.favouritesMovies()
        XCTAssertTrue(favouritesMovies.contains(502356))
    }
    
    func testRemoveMovieFromFavourites() {
        let movie = Movie(id: 1111140, title: "Two Sinners and a Mule", posterPath: Optional("/icL1zn5z1L5ULIpxkuOLjeUgURY.jpg"), overview: "Kicked out of a small Western town for sinful behavior, free-spirited Alice and Nora set out for Virginia City to pursue their dream of opening a restaurant. Out on the prairie, they come across an injured bounty hunter named Elden. Hoping to share in the reward, they nurse Elden back to health and help him stalk his prey, Grimes. But as Nora and Alice both develop feelings for Elden, no one notices that Grimes is now on their tail, and the hunters become the hunted…", releaseDate: "2023-04-21", voteAverage: 5.7, genreIds: [37, 28])
        
        repository.addMovieFavourite(movie)
        
        repository.removeMovieFromFavourite(movie)
        
        let favouritesMovies = repository.favouritesMovies()
        XCTAssertFalse(favouritesMovies.contains(1111140))
    }
    
    func testGetFavouritesMovies() async throws {
        let movie = Movie(id: 804150, title: "Cocaine Bear", posterPath: Optional("/gOnmaxHo0412UVr1QM5Nekv1xPi.jpg"), overview: "Inspired by a true story, an oddball group of cops, criminals, tourists and teens converge in a Georgia forest where a 500-pound black bear goes on a murderous rampage after unintentionally ingesting cocaine.", releaseDate: "2023-02-22", voteAverage: 6.4, genreIds: [53, 35, 80])
        repository.addMovieFavourite(movie)
        
        let favouritesMovieDetails = try await repository.getFavouritesMovies()
        
        XCTAssertFalse(favouritesMovieDetails.isEmpty)
    }
    func testPendingMovies() {
        let movies = repository.pendingMovies()
        XCTAssertNotNil(movies)
    }
    
    func testAddMovieToPending() {
        let movie = Movie(id: 502356, title: "The Super Mario Bros. Movie", posterPath: Optional("/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"), overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", releaseDate: "2023-04-05", voteAverage: 7.5, genreIds: [16, 12, 10751, 14, 35])
        
        repository.addMoviePending(movie)
        
        let pendingMovies = repository.pendingMovies()
        XCTAssertTrue(pendingMovies.contains(movie.id))
    }
    
    func testRemoveMovieFromPending() {
        let movie = Movie(id: 493529, title: "Dungeons & Dragons: Honor Among Thieves", posterPath: Optional("/v7UF7ypAqjsFZFdjksjQ7IUpXdn.jpg"), overview: "A charming thief and a band of unlikely adventurers undertake an epic heist to retrieve a lost relic, but things go dangerously awry when they run afoul of the wrong people.", releaseDate: "2023-03-23", voteAverage: 7.5, genreIds: [12, 14, 35])
        
        repository.addMoviePending(movie)
        
        repository.removeMovieFromPending(movie)
        
        let pendingMovies = repository.pendingMovies()
        XCTAssertFalse(pendingMovies.contains(movie.id))
    }
    
    func testGetPendingMovies() async throws {
        let movie = Movie(id: 804150, title: "Cocaine Bear", posterPath: Optional("/gOnmaxHo0412UVr1QM5Nekv1xPi.jpg"), overview: "Inspired by a true story, an oddball group of cops, criminals, tourists and teens converge in a Georgia forest where a 500-pound black bear goes on a murderous rampage after unintentionally ingesting cocaine.", releaseDate: "2023-02-22", voteAverage: 6.4, genreIds: [53, 35, 80])
        
        repository.addMoviePending(movie)
        
        let pendingMovieDetails = try await repository.getPendingMovies()
        
        XCTAssertFalse(pendingMovieDetails.isEmpty)
    }
    
    // Pruebas unitarias para la función moviesIndividual
    func testMoviesIndividual() async throws {
        let movieId = 123 // ID de película a consultar
        let movieDetails = try await repository.moviesIndividual(id: movieId)
        // Afirmaciones
        XCTAssertNotNil(movieDetails)
        XCTAssertEqual(movieDetails.id, movieId)
    }

    // Pruebas unitarias para la función moviesDetails
    func testMoviesDetails() async throws {
        let movieId = 123 // ID de película a consultar
        let details = try await repository.moviesDetails(id: movieId)
        // Afirmaciones
        XCTAssertNotNil(details)
    }

    // Pruebas unitarias para la función moviesCredits
    func testMoviesCredits() async throws {
        let movieId = 123 // ID de película a consultar
        let credits = try await repository.moviesCredits(id: movieId)
        // Afirmaciones
        XCTAssertNotNil(credits)
    }

    // Pruebas unitarias para la función searchMovies
    func testSearchMovies() async throws {
        let searchText = "Avengers" // Texto de búsqueda
        let movies = try await repository.searchMovies(searchText: searchText)
        // Afirmaciones
        XCTAssertNotNil(movies)
        XCTAssertFalse(movies.isEmpty)
    }

}

