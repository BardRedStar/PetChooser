//
//  ResultViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 08.01.2020.
//  Copyright © 2020 10X. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {

    lazy var prepareLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textColor = .darkGray
        label.text = "The best pet for you is..."
        label.alpha = 0.0
        label.sizeToFit()
        return label
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35.0)
        label.textColor = .black
        label.alpha = 0.0
        return label
    }()

    private var viewModel: ResultControllerViewModel!

    class func instantiate(with viewModel: ResultControllerViewModel) -> ResultViewController {
        let controller = ResultViewController()
        controller.viewModel = viewModel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calculateResult()
        configureUI()
        showResults()
    }

    private func calculateResult() {
        let result = viewModel.calculateResult()
        resultLabel.text = result
        resultLabel.sizeToFit()
    }

    private func configureUI() {
        view.addSubview(prepareLabel)
        view.addSubview(resultLabel)

        prepareLabel.frame.origin = CGPoint(x: (view.frame.width - prepareLabel.frame.width) / 2, y: view.frame.height / 2)
        resultLabel.frame.origin = CGPoint(x: (view.frame.width - resultLabel.frame.width) / 2, y: view.frame.height / 2 + 60)
    }

    private func showResults() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.prepareLabel.frame.origin.x -= 40.0
                self.prepareLabel.alpha = 1.0
            },
            completion: { [weak self] animate in
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
                    guard let self = self else { return }
                    self.resultLabel.frame.origin.x -= 40.0
                    self.resultLabel.alpha = 1.0
                }, completion: nil)
            }
        )
    }

}
