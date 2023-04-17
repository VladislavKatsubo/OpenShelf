//
//  RequestConstructor.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import Foundation

class RequestConstructor {
    private static let baseURL = "https://openlibrary.org"
    private static let coversBaseURL = "https://covers.openlibrary.org"

    enum Endpoint {
        case books(limit: Int, offset: Int)
        case image(coverId: Int?, imageSize: String)
        case description(keyWithEndpoint: String)
        case ratings(keyWithEndpoint: String)

        func url() -> URL? {
            switch self {
            case .books(let limit, let offset):
                let endpoint = "/subjects/fiction.json"
                let queryItems = [URLQueryItem(name: "limit", value: "\(limit)"),
                                  URLQueryItem(name: "offset", value: "\(offset)")]
                return constructURL(baseURL: baseURL, endpoint: endpoint, queryItems: queryItems)

            case .image(let coverId, let imageSize):
                guard let coverId = coverId else { return nil }
                let endpoint = "/b/id/\(coverId)-\(imageSize).jpg"
                return constructURL(baseURL: coversBaseURL, endpoint: endpoint, queryItems: nil)

            case .description(let keyWithEndpoint):
                let endpoint = "\(keyWithEndpoint).json"
                return constructURL(baseURL: baseURL, endpoint: endpoint, queryItems: nil)

            case .ratings(let keyWithEndpoint):
                let endpoint = "\(keyWithEndpoint)/ratings.json"
                return constructURL(baseURL: baseURL, endpoint: endpoint, queryItems: nil)
            }
        }
    }

    private static func constructURL(baseURL: String, endpoint: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.path = endpoint
        components?.queryItems = queryItems
        return components?.url
    }
}
