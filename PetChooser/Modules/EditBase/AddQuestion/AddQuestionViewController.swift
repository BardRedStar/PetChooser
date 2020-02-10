//
//  AddQuestionViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

class AddQuestionViewController: EntityViewController {
    var viewModel: AddQuestionControllerViewModel {
        return baseViewModel as! AddQuestionControllerViewModel
    }

    class func instantiate(viewModel: AddQuestionControllerViewModel) -> AddQuestionViewController {
        let controller = AddQuestionViewController()
        controller.baseViewModel = viewModel
        return controller
    }

    override func setupUI() {
        super.setupUI()
        titleLabel.text = ContentType.questions.title
    }
}
