//
//  ViewController.swift
//  PetChooser
//
//  Created by Denis Kovalev on 06.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var questionPageControl: UIPageControl!

    var editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editModeDidClick))
    var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDidClick))

    var viewModel = MainControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureNavigationBar()
        loadData()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.allowsSelection = false
    }

    private func configureNavigationBar() {
        editButton.action = #selector(editModeDidClick)
        editButton.target = self
        doneButton.action = #selector(doneDidClick)
        doneButton.target = self
        navigationItem.rightBarButtonItem = editButton
    }

    private func loadData() {
        viewModel.loadData()
        configurePageControl()
        collectionView.reloadData()
    }

    private func configurePageControl() {
        questionPageControl.numberOfPages = viewModel.items.count
        questionPageControl.currentPage = 0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = calculateCurrentPage()
        questionPageControl.currentPage = page
        viewModel.currentPage = page

        navigationItem.rightBarButtonItems = page == viewModel.items.count - 1 ? [editButton, doneButton] : [editButton]
    }

    private func calculateCurrentPage() -> Int {
        return Int(floor(collectionView.contentOffset.x / collectionView.frame.size.width))
    }

    @objc private func editModeDidClick(_ sender: Any) {
        let controller = AdminViewController.instantiate()!
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func doneDidClick(_ sender: UIButton) {
        if viewModel.items.first(where: {$0.selectedAnswer == nil}) != nil {
            print("Some of questions weren't answered!")
            return
        }

        let resultViewModel = ResultControllerViewModel()
        resultViewModel.testResults = viewModel.items.map { $0.selectedAnswer! }
        let controller = ResultViewController.instantiate(with: resultViewModel)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.questionCollectionViewCell, for: indexPath)!
        cell.configureWith(viewModel.items[indexPath.section])
        cell.delegate = self
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension MainViewController: QuestionCollectionViewCellDelegate {
    func questionCollectionViewCell(_ cell: QuestionCollectionViewCell, didSelectItemAt indexPath: IndexPath) {
        viewModel.items[viewModel.currentPage].selectedAnswer = Answer.allCases[indexPath.row]
    }
}
