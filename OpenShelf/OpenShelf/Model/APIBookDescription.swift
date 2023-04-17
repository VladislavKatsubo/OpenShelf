//
//  APIBookDescription.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import Foundation

struct APIBookDescription: Decodable {
    let description: String?

    enum CodingKeys: String, CodingKey {
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            if let descriptionContainer = try? container.nestedContainer(keyedBy: DescriptionCodingKeys.self, forKey: .description) {
                description = try descriptionContainer.decode(String.self, forKey: .value)
            } else {
                description = try container.decode(String.self, forKey: .description)
            }
        } catch {
            description = nil
        }
    }

    enum DescriptionCodingKeys: String, CodingKey {
        case value
    }
}
