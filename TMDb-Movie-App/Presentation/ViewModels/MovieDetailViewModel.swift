//
//  MovieDetailViewModel.swift
//  TMDb-Movie-App
//

import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject {

    @Published private(set) var movieDetail: MovieDetail?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var isFavorite: Bool

    let movie: Movie
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let favoritesManager: FavoritesManagerProtocol

    init(
        movie: Movie,
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCase,
        favoritesManager: FavoritesManagerProtocol
    ) {
        self.movie                    = movie
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.favoritesManager         = favoritesManager
        self.isFavorite               = favoritesManager.isFavorite(movie.id)
    }

    func loadDetails() async {
        isLoading = true
        errorMessage = nil
        do {
            movieDetail = try await fetchMovieDetailsUseCase.execute(id: movie.id)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func toggleFavorite() {
        if isFavorite {
            favoritesManager.removeFavorite(movie.id)
        } else {
            favoritesManager.addFavorite(movie.id)
        }
        isFavorite = favoritesManager.isFavorite(movie.id)
    }
}
