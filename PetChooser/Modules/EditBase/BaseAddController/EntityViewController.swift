//
//  EntityViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 09.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class EntityViewController: UIViewController {
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(R.nib.entityTableViewCell)
        return tableView
    }()

    var baseViewModel: EntityControllerViewModel!

    var onEntityDidAdd: (()->Void)?

    class func instantiate(viewModel: EntityControllerViewModel) -> EntityViewController {
        let controller = EntityViewController()
        controller.baseViewModel = viewModel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        loadData()
    }

    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                            action: #selector(doneButtonDidTap))
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)

        constrain(view, tableView, titleLabel, titleTextField) { parent, table, title, titleField in
            title.left == parent.safeAreaLayoutGuide.left + 20
            title.top == parent.safeAreaLayoutGuide.top + 20
            title.bottom == titleField.top - 10

            titleField.left == parent.safeAreaLayoutGuide.left + 20
            titleField.right == parent.safeAreaLayoutGuide.right - 20
            titleField.bottom == table.top - 10

            table.left == parent.safeAreaLayoutGuide.left
            table.right == parent.safeAreaLayoutGuide.right
            table.bottom == parent.safeAreaLayoutGuide.bottom
        }
    }

    private func loadData() {
        baseViewModel.loadData()
        tableView.reloadData()
    }

    @objc private func doneButtonDidTap(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else {
            print("Title is empty!")
            return
        }

        for index in 0..<baseViewModel.items.count {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! EntityTableViewCell
            let entity = cell.getInfo()
            baseViewModel.items[index] = entity
        }

        baseViewModel.addEntityWith(title: title, items: baseViewModel.items)
        onEntityDidAdd?()
    }

    func cellDidConfigure(_ cell: EntityTableViewCell) {}
}

extension EntityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseViewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.entityTableViewCell, for: indexPath)
        else {
            fatalError("Error while initializing the EntityTableViewCell!")
        }

        cell.configureWith(model: baseViewModel.items[indexPath.row])
        cellDidConfigure(cell)
        return cell
    }
}

