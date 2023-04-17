//
//  BookShelfTablieViewCell+Model.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import Foundation

extension BookShelfTableViewCell {
    struct Model {
        let title: String?
        let author: String?
        let coverID: Int?
        let firstPublicationYear: Int?
        let averageRating: Double?
    }
}
