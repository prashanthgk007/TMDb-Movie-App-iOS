//
//  FetchPopularMoviesUseCase.swift
//  TMDb-Movie-App
//

import Foundation

final class FetchPopularMoviesUseCase {

    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func execute(page: Int = 1) async throws -> MovieResponse {
        try await movieService.fetchPopularMovies(page: page)
    }
}
