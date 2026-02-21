//
//  MovieDataSession.swift
//  TMDb-Movie-App
//

import Foundation
import Combine

/// Observable session that drives the UI.
/// Holds any `MovieDataSourceProtocol` — inject `MockMovieDataSource` now,
/// swap with `APIMovieDataSource` later without changing any View code.
final class MovieDataSession: ObservableObject {

    // MARK: - Published State
    @Published private(set) var popularMovies: [MockMovie] = []
    @Published private(set) var searchResults: [MockMovie] = []
    @Published private(set) var favorites: Set<Int> = []

    // MARK: - Private
    private let dataSource: MovieDataSourceProtocol

    // MARK: - Init
    init(dataSource: MovieDataSourceProtocol) {
        self.dataSource = dataSource
    }

    // MARK: - Popular
    func loadPopularMovies() {
        popularMovies = dataSource.fetchPopularMovies()
    }

    // MARK: - Search
    func search(query: String) {
        searchResults = dataSource.searchMovies(query: query)
    }

    func clearSearch() {
        searchResults = []
    }

    // MARK: - Favorites
    func toggleFavorite(id: Int) {
        if favorites.contains(id) { favorites.remove(id) }
        else { favorites.insert(id) }
    }

    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }

    var favoriteMovies: [MockMovie] {
        popularMovies.filter { favorites.contains($0.id) }
    }
}
