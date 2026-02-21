//
//  Endpoint.swift
//  TMDb-Movie-App
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    case patch  = "PATCH"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    let headers: [String: String]?

    init(
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String]? = nil
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConfig.baseHost
        components.path = APIConfig.basePath + path

        var items = queryItems ?? []
        items.append(URLQueryItem(name: "api_key", value: APIConfig.apiKey))
        components.queryItems = items

        return components.url
    }
}

// MARK: - TMDb Endpoints
extension Endpoint {
    static func popularMovies(page: Int = 1) -> Endpoint {
        Endpoint(path: "/movie/popular",
                 queryItems: [URLQueryItem(name: "page", value: "\(page)")])
    }

    static func searchMovies(query: String, page: Int = 1) -> Endpoint {
        Endpoint(path: "/search/movie",
                 queryItems: [
                     URLQueryItem(name: "query", value: query),
                     URLQueryItem(name: "page", value: "\(page)")
                 ])
    }

    static func movieDetails(id: Int) -> Endpoint {
        Endpoint(path: "/movie/\(id)")
    }
}
