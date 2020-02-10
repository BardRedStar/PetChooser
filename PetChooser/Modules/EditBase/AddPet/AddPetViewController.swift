//
//  AddPetViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 11.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

class AddPetViewController: EntityViewController {

    var viewModel: AddPetControllerViewModel {
        return baseViewModel as! AddPetControllerViewModel
    }

    class func instantiate(viewModel: AddPetControllerViewModel) -> AddPetViewController {
        let controller = AddPetViewController()
        controller.baseViewModel = viewModel
        return controller
    }


    override func setupUI() {
        super.setupUI()
        titleLabel.text = ContentType.pets.title
        titleLabel.sizeToFit()
    }
}
