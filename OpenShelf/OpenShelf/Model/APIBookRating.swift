//
//  APIBookRating.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import Foundation

struct APIBookRating: Decodable {
    let summary: Summary?

    struct Summary: Decodable {
        let average: Double?
        let count: Int?
    }
}
