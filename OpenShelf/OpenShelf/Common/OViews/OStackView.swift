//
//  OStackView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 16.04.23.
//

import UIKit

class OStackView: UIStackView {

    init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0.0) {
        super.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

