//
//  SearchMoviesUseCase.swift
//  TMDb-Movie-App
//

import Foundation

final class SearchMoviesUseCase {

    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func execute(query: String, page: Int = 1) async throws -> MovieResponse {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return MovieResponse(page: 1, results: [], totalPages: 0, totalResults: 0)
        }
        return try await movieService.searchMovies(query: query, page: page)
    }
}
