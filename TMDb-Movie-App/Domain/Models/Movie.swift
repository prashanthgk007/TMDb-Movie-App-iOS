//
//  Movie.swift
//  TMDb-Movie-App
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    let genreIDs: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath    = "poster_path"
        case backdropPath  = "backdrop_path"
        case voteAverage   = "vote_average"
        case releaseDate   = "release_date"
        case genreIDs      = "genre_ids"
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: APIConfig.imageBase + path)
    }

    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: APIConfig.imageBase + path)
    }

    var formattedRating: String {
        String(format: "%.1f", voteAverage)
    }
}
