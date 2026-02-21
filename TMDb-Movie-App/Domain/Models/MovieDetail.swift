//
//  MovieDetail.swift
//  TMDb-Movie-App
//

import Foundation

struct MovieDetail: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    let runtime: Int?
    let genres: [Genre]
    let tagline: String?

    struct Genre: Codable {
        let id: Int
        let name: String
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, tagline, runtime
        case posterPath    = "poster_path"
        case backdropPath  = "backdrop_path"
        case voteAverage   = "vote_average"
        case releaseDate   = "release_date"
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: APIConfig.imageBase + path)
    }

    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: APIConfig.imageBase + path)
    }

    var formattedRuntime: String {
        guard let runtime else { return "N/A" }
        return "\(runtime / 60)h \(runtime % 60)m"
    }

    var genreNames: String {
        genres.map(\.name).joined(separator: ", ")
    }
}
