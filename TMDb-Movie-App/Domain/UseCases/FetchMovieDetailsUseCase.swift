//
//  FetchMovieDetailsUseCase.swift
//  TMDb-Movie-App
//

import Foundation
import Combine

final class FetchMovieDetailsUseCase {

    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func execute(id: Int) async throws -> MovieDetail {
        try await movieService.fetchMovieDetails(id: id)
    }
}
