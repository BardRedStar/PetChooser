//
//  AdminViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

class AdminViewController: UIViewController {

    @IBOutlet private weak var tabBar: UITabBar!
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = AdminControllerViewModel()

    class func instantiate() -> AdminViewController? {
        let controller = R.storyboard.adminStoryboard.adminViewController()
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureTabBar()
        configureNavigationBar()
        loadData()
    }

    private func configureTableView() {
        tableView.sectionIndexColor = .white
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NameCell")
    }

    private func configureTabBar() {
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?.first
    }

    private func configureNavigationBar() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain,
                                                                target: self, action: #selector(addButtonDidTap))
    }


    private func loadData() {
        viewModel.loadData()
        tableView.reloadData()
    }

    @objc private func addButtonDidTap(_ sender: Any) {
        let controller: EntityViewController
        switch viewModel.currentContentType {
        case .pets:
            controller = AddPetViewController.instantiate(viewModel: AddPetControllerViewModel())
        case .questions:
            controller = AddQuestionViewController.instantiate(viewModel: AddQuestionControllerViewModel())
        }
        controller.onEntityDidAdd = { [weak self] in
            guard let self = self else { return }
            self.loadData()
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension AdminViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = viewModel.items[indexPath.row]
        return cell
    }
}

extension AdminViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = ShowControllerViewModel()
        viewModel.entityTitle = self.viewModel.items[indexPath.row]
        viewModel.contentType = self.viewModel.currentContentType
        let controller = ShowViewController.instantiate(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            self.viewModel.deleteItem(at: indexPath.row)
            self.tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension AdminViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        viewModel.currentContentType = ContentType(rawValue: item.title!)!
        tableView.reloadData()
    }
}
