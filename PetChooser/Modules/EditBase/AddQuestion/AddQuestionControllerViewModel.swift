//
//  AddQuestionControllerViewModel.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation

class AddQuestionControllerViewModel: EntityControllerViewModel {

    var pets: [Pet] = []

    override func loadData() {
        pets = Pet.allPets()
        items = pets.map{ EntityViewModel(name: $0.name!) }
    }

    override func addEntityWith(title: String, items: [EntityViewModel]) {
        let question = Question(context: CoreDataManager.instance.persistentContainer.viewContext)
        question.text = title

        for item in items {
            let probability = Probability(context: CoreDataManager.instance.persistentContainer.viewContext)
            probability.plus = item.plus
            probability.minus = item.minus
            probability.question = question
            probability.pet = pets.first{ $0.name == item.name }
        }
        CoreDataManager.instance.saveContext()
    }
}
