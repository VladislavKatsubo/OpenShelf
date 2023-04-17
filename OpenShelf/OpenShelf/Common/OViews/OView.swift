//
//  OView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import UIKit

class OView: UIView {

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        didLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func didLoad() {

    }
}
