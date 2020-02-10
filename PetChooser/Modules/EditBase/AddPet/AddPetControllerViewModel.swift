//
//  AddPetControllerViewModel.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

class AddPetControllerViewModel: EntityControllerViewModel {

    var questions: [Question] = []

    override func loadData() {
        questions = Question.allQuestions()
        items = questions.map{ EntityViewModel(name: $0.text!) }
    }

    override func addEntityWith(title: String, items: [EntityViewModel]) {
        let pet = Pet(context: CoreDataManager.instance.persistentContainer.viewContext)
        pet.name = title

        for item in items {
            let probability = Probability(context: CoreDataManager.instance.persistentContainer.viewContext)
            probability.plus = item.plus
            probability.minus = item.minus
            probability.pet = pet
            probability.question = questions.first{ $0.text == item.name }
        }
        CoreDataManager.instance.saveContext()
    }

}
