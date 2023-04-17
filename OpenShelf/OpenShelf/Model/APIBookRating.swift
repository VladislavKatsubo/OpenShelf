//
//  APIBookRating.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import Foundation

struct APIBookRating: Decodable {
    let summary: Average?

    struct Average: Decodable {
        let average: Double?
    }
}
