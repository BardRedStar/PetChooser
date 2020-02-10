//
//  EntityTableViewCell.swift
//  PetChooser
//
//  Created by Denis Kovalev on 11.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

class EntityTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var plusTextField: UITextField!
    @IBOutlet private weak var minusTextField: UITextField!

    func configureWith(model: EntityViewModel) {
        nameLabel.text = model.name
        plusTextField.text = String(model.plus)
        minusTextField.text = String(model.minus)
    }

    func getInfo() -> EntityViewModel {
        return EntityViewModel(plus: Double(plusTextField.text!)!, minus: Double(minusTextField.text!)!, name: nameLabel.text!)
    }

    func makeFielsImmutable() {
        plusTextField.isEnabled = false
        minusTextField.isEnabled = false
    }
}
