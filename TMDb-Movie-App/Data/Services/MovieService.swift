//
//  MovieService.swift
//  TMDb-Movie-App
//

import Foundation

final class MovieService: MovieServiceProtocol {

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchPopularMovies(page: Int) async throws -> MovieResponse {
        try await apiService.request(.popularMovies(page: page))
    }

    func searchMovies(query: String, page: Int) async throws -> MovieResponse {
        try await apiService.request(.searchMovies(query: query, page: page))
    }

    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        try await apiService.request(.movieDetails(id: id))
    }
}
