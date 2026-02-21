//
//  HomeViewModel.swift
//  TMDb-Movie-App
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    private var currentPage = 1
    private var totalPages  = 1

    var canLoadMore: Bool { currentPage < totalPages }

    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
    }

    func loadMovies() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            let response  = try await fetchPopularMoviesUseCase.execute(page: 1)
            movies        = response.results
            currentPage   = response.page
            totalPages    = response.totalPages
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func loadNextPage() async {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        do {
            let response  = try await fetchPopularMoviesUseCase.execute(page: currentPage + 1)
            movies       += response.results
            currentPage   = response.page
            totalPages    = response.totalPages
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
