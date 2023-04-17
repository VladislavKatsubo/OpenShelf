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
    }

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var cellModels: [BookShelfTableViewCell.Model] = []

    var onTap: ((BookShelfTableViewCell.Model) -> Void)?

    // MARK: - Configure
    func configure(with cellModels: [BookShelfTableViewCell.Model]) {
        self.cellModels = cellModels
        self.tableView.reloadData()
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
        tableView.register(BookShelfTableViewCell.self, forCellReuseIdentifier: BookShelfTableViewCell.reuseID)

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
        cellModels.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookShelfTableViewCell.reuseID,
            for: indexPath
        ) as? BookShelfTableViewCell else {
            return .init()
        }

        let model = cellModels[indexPath.row]
        let session = URLSession(configuration: .default)
        let networkManager = NetworkManager(session: session)
        let imageManager = ImageManager(networkManager: networkManager)
        let viewModel = BookShelfTableViewCellViewModel(
            model: model,
            imageManager: imageManager
        )
        
        cell.configure(with: viewModel)

        return cell
    }
}
