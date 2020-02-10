//
//  AdminControllerViewModel.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

class AdminControllerViewModel {
    var items: [String] = []
    var currentContentType: ContentType = .pets {
        didSet {
            loadData()
        }
    }

    func loadData() {
        switch currentContentType {
        case .pets:
            let results = Pet.allPets()
            items = results.map{ $0.name! }
        case .questions:
            let results = Question.allQuestions()
            items = results.map{ $0.text! }
        }
    }

    func deleteItem(at index: Int) {
        let resultObject = (currentContentType == .pets) ? Pet.petWith(name: items[index]) : Question.questionWith(text: items[index])
        guard let object = resultObject else {
            print("Object \(items[index]) was not found")
            items.remove(at: index)
            return
        }
        items.remove(at: index)
        CoreDataManager.instance.persistentContainer.viewContext.delete(object)
    }
}
