//
//  ShowViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

class ShowViewController: EntityViewController {

    var viewModel: ShowControllerViewModel {
        return baseViewModel as! ShowControllerViewModel
    }

    class func instantiate(viewModel: ShowControllerViewModel) -> EntityViewController {
        let controller = ShowViewController()
        controller.baseViewModel = viewModel
        return controller
    }

    override func setupUI() {
        super.setupUI()
        title = (viewModel.contentType == .pets) ? "Pet info" : "Question info"
        titleLabel.text = viewModel.contentType?.title
        titleTextField.text = viewModel.entityTitle
        titleTextField.isEnabled = false
    }

    override func configureNavigationBar() {}

    override func cellDidConfigure(_ cell: EntityTableViewCell) {
        cell.makeFielsImmutable()
    }
}
