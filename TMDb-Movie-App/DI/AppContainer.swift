//
//  AppContainer.swift
//  TMDb-Movie-App
//

import Foundation
import Combine

final class AppContainer: ObservableObject {

    // MARK: - Core
    lazy var apiService: APIServiceProtocol = APIService()

    // MARK: - Data
    lazy var movieService: MovieServiceProtocol = MovieService(apiService: apiService)
    lazy var favoritesManager: FavoritesManagerProtocol = FavoritesManager()

    // MARK: - Use Cases
    lazy var fetchPopularMoviesUseCase = FetchPopularMoviesUseCase(movieService: movieService)
    lazy var searchMoviesUseCase        = SearchMoviesUseCase(movieService: movieService)
    lazy var fetchMovieDetailsUseCase   = FetchMovieDetailsUseCase(movieService: movieService)

    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(fetchPopularMoviesUseCase: fetchPopularMoviesUseCase)
    }

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(searchMoviesUseCase: searchMoviesUseCase)
    }

    func makeMovieDetailViewModel(movie: Movie) -> MovieDetailViewModel {
        MovieDetailViewModel(
            movie: movie,
            fetchMovieDetailsUseCase: fetchMovieDetailsUseCase,
            favoritesManager: favoritesManager
        )
    }
}
