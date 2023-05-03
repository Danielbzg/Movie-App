//
//  MovieDetailView.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State private var movieCredits: Credits? = nil
    @State private var movieDetails: Details? = nil
    
    let movie: Movie
    @State var isFavourite: Bool
    @State var isPending: Bool
    @State var credits: String = ""
    
    init(movie: Movie) {
        self.movie = movie
        self.isFavourite = movie.isFavourite
        self.isPending = movie.isPending
    }
    
    var body: some View {
        
        VStack {

            ScrollView(.vertical) {

                headerView

                VStack(spacing: 16) {

                    HStack(alignment: .center, spacing: 5) {

                        Text("Estreno \(movie.formattedReleaseDate ?? "")")

                        Text(" · ")

                        Text("Duración \(String(movieDetails?.duration ?? 0)) min.")

                    }
                    .font(.callout)
                    .foregroundColor(Color.dsSecondary)

                    genresView

                    actionButtons

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Sinopsis")
                            .foregroundColor(Color.dsSecondary)

                        Text(movie.overview)
                            .foregroundColor(Color.longText)
                    }

                    if let director = movieCredits?.director {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Director")
                                .foregroundColor(Color(red: 121/255, green: 128/255, blue: 176/255))
                            Text(String(director.name))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Reparto")
                            .foregroundColor(Color.dsSecondary)

                        ScrollView(.horizontal){

                            HStack(alignment: .top, spacing: 16)  {

                                if let mainCharacters = movieCredits?.mainCharacters {

                                    ForEach(mainCharacters) { character in

                                        VStack(spacing: 8) {

                                            AsyncImage(
                                                url: RemoteImage.movieImage(path: character.profilePath ?? "")
                                            ) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                Image("PosterDefault")
                                            } //Fin imagen
                                            .frame(height: 86)
                                            .background(Color.dsSecondary)
                                            .cornerRadius(25)

                                            VStack(alignment: .leading, spacing: 4) {

                                                Text(character.name)
                                                    .font(.footnote)
                                                    .foregroundColor(Color.white)

                                                Text(character.character)
                                                    .font(.caption)
                                                    .foregroundColor(Color.gray)
                                            }
                                        }
                                        .frame(width: 86)
                                    }
                                }
                            }
                        }
                        .frame(width: .infinity, alignment: .trailing)
                        .frame(minHeight: 150)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.main)
        .onAppear {
            loadCredits()
            loadMovieDetails()
        }
    }

    var posterMaskGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.red, Color.red, Color.red, Color.main.opacity(0)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var headerView: some View {

        ZStack {
            AsyncImage(url: RemoteImage.movieImage(path: movie.posterPath ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .mask(posterMaskGradient)
            } placeholder: {
                ProgressView()
            }

            VStack{
                Spacer()
                Text(movie.title)
                    .foregroundColor(Color.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
        }
    }

    var genresView: some View {

        HStack {

            if let generos = movieDetails?.generos {

                LazyVGrid(
                    columns: [GridItem(.flexible(minimum:115), spacing: 8), GridItem(.flexible(minimum:115), spacing: 8)]
                ) {
                    ForEach(generos, id: \.self) { genero in

                        ZStack{
                            
                            Rectangle()
                                .fill(Color.backgroundButton)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.dsSecondary, lineWidth: 0.5)
                                )
                                .cornerRadius(20)

                            Text(genero)
                                .font(.caption)
                                .padding(2)
                                .foregroundColor(Color.dsSecondary)
                        }
                    }
                }
            }
        }
    }

    var actionButtons: some View {
        //Botones Favoritos - Pendientes...
        HStack(spacing: 32)  {

            ActionButton(icon: isFavourite ? "fullHeart" : "emptyHeart") {
                if isFavourite {
                    Dependencies.repository.removeMovieFromFavourite(movie)
                } else {
                    Dependencies.repository.addMovieFavourite(movie)
                }
                isFavourite.toggle()

                print("Película a añadir a favoritas: \(movie)")
            }

            ActionButton(icon: isPending ? "save" : "noSave") {
                if isPending {
                    Dependencies.repository.removeMovieFromPending(movie)
                } else {
                    Dependencies.repository.addMoviePending(movie)
                }
                isPending.toggle()

                print("Película a añadir a pendientes: \(movie)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func loadCredits() {
        Task {
            do {
                let movieCredits = try await Dependencies.repository.moviesCredits(id: movie.id)
                print(movieCredits)
                self.movieCredits = movieCredits
            } catch {
                print(error)
            }
        }
    }
    
    func loadMovieDetails() {
        Task {
            do {
                //print("El valor de movie.id: \(movie.id)")
                let movieDetails = try await Dependencies.repository.moviesDetails(id: movie.id)
                print(movieDetails)
                self.movieDetails = movieDetails
            } catch {
                print(error)
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {

        NavigationView {
            MovieDetailView(movie: Movie(id: 502356, title: "The Super Mario Bros. Movie", posterPath: Optional("/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"), overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", releaseDate: "2023-04-05", voteAverage: 7.5, genreIds: [16, 12, 10751, 14, 35]))
        }
    }
}
