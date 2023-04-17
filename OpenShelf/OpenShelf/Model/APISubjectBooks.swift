//
//  APIResponse.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import Foundation

struct APISubjectBooks: Decodable {
    let works: [Book]
}

struct Book: Decodable {
    let key: String?
    let title: String?
    let coverId: Int?
    let authors: [Author]?
    let firstPublishYear: Int?

    struct Author: Decodable {
        let name: String?
    }
}

