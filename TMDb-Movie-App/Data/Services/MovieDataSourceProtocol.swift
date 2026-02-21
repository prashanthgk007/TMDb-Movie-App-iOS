//
//  MovieDataSourceProtocol.swift
//  TMDb-Movie-App
//

import Foundation

protocol MovieDataSourceProtocol {
    /// Returns a list of popular movies.
    func fetchPopularMovies() -> [MockMovie]

    /// Returns movies matching the given search query.
    func searchMovies(query: String) -> [MockMovie]
}
