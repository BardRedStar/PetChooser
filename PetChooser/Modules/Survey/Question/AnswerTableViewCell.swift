//
//  AnswerTableViewCell.swift
//  PetChooser
//
//  Created by Denis Kovalev on 17.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet private weak var answerLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureWith(title: String) {
        answerLabel.text = title
    }

}
