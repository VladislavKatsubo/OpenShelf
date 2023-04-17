//
//  BookShelfViewController.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import UIKit

final class BookShelfViewController: UIViewController {

    typealias Constants = BookShelfResources.Constants.UI

    private var viewModel: BookShelfViewModelProtocol?

    private let stackView = OStackView(axis: .vertical)
    private let profileView = BookShelfProfileView()
    private let tableLabel = BookShelfTableLabel()
    private let tableView = BookShelfTableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: BookShelfViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension BookShelfViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .onSetProfileView(let model):
                self.profileView.configure(with: model)
            case .onFetchBooks(let models, let imageManager):
                self.tableView.configure(with: models, and: imageManager)
            case .onSelectBook(let model):
                let detailViewController = BookDetailsFactory().createController(with: model)
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
        viewModel?.launch()
    }

    func setupItems() {
        view.backgroundColor = Constants.backgroundColor

        setupStackView()
        setupTableView()
    }

    func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(profileView)
        stackView.setCustomSpacing(Constants.spacingAfterProfileView, after: profileView)
        stackView.addArrangedSubview(tableLabel)
        stackView.setCustomSpacing(Constants.spacingAfterTableLabel, after: tableLabel)
        stackView.addArrangedSubview(tableView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.stackViewTopOffset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewLeadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.stackViewTrailingInset),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.onTap = { [weak self] model in
            self?.viewModel?.onStateChange?(.onSelectBook(model))
        }
    }
}
