//
//  BookShelfTableView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import UIKit

final class BookShelfTableView: OView {

    private enum Constants {
        static let rowHeight: CGFloat = 165.0
        static let skeletonCellsCount: Int = 4
    }

    private var imageManager: ImageManagerProtocol?

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var cellModels: [BookShelfTableViewCell.Model] = [] {
        didSet {
            isRealData = true
        }
    }

    var onTap: ((BookShelfTableViewCell.Model) -> Void)?

    private var isRealData: Bool = false

    // MARK: - Configure
    func configure(with cellModels: [BookShelfTableViewCell.Model], and imageManager: ImageManagerProtocol) {
        self.cellModels = cellModels
        self.imageManager = imageManager
        self.tableView.isUserInteractionEnabled = true
        self.tableView.reloadDataWithAnimation()
    }

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setupTableView()
    }
}

private extension BookShelfTableView {
    // MARK: - Private methods
    func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = false
        tableView.register(BookShelfTableViewCell.self, forCellReuseIdentifier: BookShelfTableViewCell.reuseID)
        tableView.register(BookShelfTableViewSkeletonCell.self, forCellReuseIdentifier: BookShelfTableViewSkeletonCell.reuseID)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension BookShelfTableView: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTap?(cellModels[indexPath.row])
    }
}

extension BookShelfTableView: UITableViewDataSource {
    // MARK: - UITableViewDataSouce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isRealData ? cellModels.count : Constants.skeletonCellsCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard isRealData else {
            guard let skeletonCell = tableView.dequeueReusableCell(
                withIdentifier: BookShelfTableViewSkeletonCell.reuseID,
                for: indexPath
            ) as? BookShelfTableViewSkeletonCell else {
                return .init()
            }
            return skeletonCell
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookShelfTableViewCell.reuseID,
            for: indexPath
        ) as? BookShelfTableViewCell,
              let imageManager = imageManager else {
            return .init()
        }

        let model = cellModels[indexPath.row]
        let viewModel = BookShelfTableViewCellViewModel(
            model: model,
            imageManager: imageManager
        )
        
        cell.configure(with: viewModel)

        return cell
    }
}
