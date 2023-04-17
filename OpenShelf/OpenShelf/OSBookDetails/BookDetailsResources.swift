//
//  BookDetailsResources.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import UIKit

struct BookDetailsResources {
    // MARK: - States
    enum State {
        case onFetchBookDescription(String?)
        case onFetchBookImageData(Data)
        case onSetBookInfo(BookDetailCoverBackgroundView.Model)
        case onSetBookRating(BookFullRatingView.Model)
    }

    enum Constants {
        enum UI {
            static let descriptionLabelFont: UIFont = .systemFont(ofSize: 20.0, weight: .regular)
            static let backgroundCoverImageViewHeightMultiplier: CGFloat = 0.6

            static let descriptionLabelTopOffset: CGFloat = 20.0
            static let descriptionLabelLeadingOffset: CGFloat = 20.0
            static let descriptionLabelTrailingInset: CGFloat = -20.0
            static let descriptionLabelBottomInset: CGFloat = -20.0
        }

        enum Mocks {
            static let imageSizeType: String = "L"
        }
    }
}
