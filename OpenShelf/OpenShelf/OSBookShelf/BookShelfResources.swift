//
//  BookShelfResources.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import UIKit

struct BookShelfResources {
    // MARK: - States
    enum State {
        case onSetProfileView(BookShelfProfileView.Model)
        case onFetchBooks([BookShelfTableViewCell.Model], ImageManagerProtocol)
        case onSelectBook(BookShelfTableViewCell.Model)
    }

    enum Constants {
        enum UI {
            static let spacingAfterProfileView: CGFloat = 30.0
            static let spacingAfterTableLabel: CGFloat = 20.0
            static let backgroundColor: UIColor = .systemGray6

            static let stackViewTopOffset: CGFloat = 20.0
            static let stackViewLeadingOffset: CGFloat = 20.0
            static let stackViewTrailingInset: CGFloat = -20.0
        }

        enum Mocks {
            static let booksResponseLimit: Int = 20
            static let startingRequestOffset: Int = 0
            static let bookCoverImageSize: String = "M"

            static let profileIcon: UIImage? = UIImage(named: "avatar")
            static let profileViewMock: BookShelfProfileView.Model = .init(
                name: "Vladislav",
                image: profileIcon
            )
        }
    }
}
