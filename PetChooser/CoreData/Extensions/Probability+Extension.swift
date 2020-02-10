//
//  Probability+Extension.swift
//  PetChooser
//
//  Created by Denis Kovalev on 16.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

extension Probability {

    class func allProbabilities() -> [Probability] {
        do {
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(Probability.fetchRequest())
        } catch let error {
            print(error)
            return []
        }
    }

    class func probabilitiesForPetWith(name: String) -> [Probability] {
        do {
            let request: NSFetchRequest<Probability> = Probability.fetchRequest()
            request.predicate = NSPredicate(format: "pet.name == %@", name)
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

    class func probabilitiesForQuestionsWith(text: String) -> [Probability] {
        do {
            let request: NSFetchRequest<Probability> = Probability.fetchRequest()
            request.predicate = NSPredicate(format: "question.text == %@", text)
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

}
