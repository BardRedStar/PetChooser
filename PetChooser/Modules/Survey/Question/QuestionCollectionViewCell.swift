//
//  QuestionCollectionViewCell.swift
//  PetChooser
//
//  Created by Denis Kovalev on 16.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import UIKit

protocol QuestionCollectionViewCellDelegate: class {
    func questionCollectionViewCell(_ cell: QuestionCollectionViewCell, didSelectItemAt indexPath: IndexPath)
}

class QuestionCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: QuestionViewModel?

    weak var delegate: QuestionCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    func configureWith(_ model: QuestionViewModel) {
        viewModel = model

        questionTitleLabel.text = viewModel?.questionText
        tableView.reloadData()

        if let selectedIndex = Answer.allCases.firstIndex(where: { $0 == viewModel?.selectedAnswer }) {
            let cell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))
            cell?.setSelected(true, animated: false)
        }
    }

    func createBackgroundView() -> UIView {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradient"

        gradientLayer.colors = [#colorLiteral(red: 0.6601528138, green: 1, blue: 0.6474614144, alpha: 0.6282641267).cgColor,
                                UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.locations = [0.5, 1]
        gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 80.0))
        view.layer.addSublayer(gradientLayer)
        return view
    }
}

extension QuestionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Answer.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerTableViewCell, for: indexPath)!
        cell.configureWith(title: Answer.allCases[indexPath.row].rawValue)
        cell.selectedBackgroundView = createBackgroundView()
        return cell
    }
}

extension QuestionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.questionCollectionViewCell(self, didSelectItemAt: indexPath)
    }
}
