//
//  SearchViewModel.swift
//  TMDb-Movie-App
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var searchQuery = ""
    @Published private(set) var results: [Movie] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let searchMoviesUseCase: SearchMoviesUseCase
    private var cancellables = Set<AnyCancellable>()

    init(searchMoviesUseCase: SearchMoviesUseCase) {
        self.searchMoviesUseCase = searchMoviesUseCase
        bindSearch()
    }

    private func bindSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task { await self?.search(query: query) }
            }
            .store(in: &cancellables)
    }

    private func search(query: String) async {
        guard !query.isEmpty else {
            results = []
            return
        }
        isLoading    = true
        errorMessage = nil
        do {
            let response = try await searchMoviesUseCase.execute(query: query)
            results      = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
