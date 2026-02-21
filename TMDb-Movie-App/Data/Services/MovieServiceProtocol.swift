//
//  MovieServiceProtocol.swift
//  TMDb-Movie-App
//

import Foundation

protocol MovieServiceProtocol {
    func fetchPopularMovies(page: Int) async throws -> MovieResponse
    func searchMovies(query: String, page: Int) async throws -> MovieResponse
    func fetchMovieDetails(id: Int) async throws -> MovieDetail
}
