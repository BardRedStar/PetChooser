//
//  Question+Extension.swift
//  PetChooser
//
//  Created by Denis Kovalev on 16.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

extension Question {
    class func allQuestions() -> [Question] {
        do {
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(Question.fetchRequest())
        } catch let error {
            print(error)
            return []
        }
    }

    class func questionWith(text: String) -> Question? {
        do {
            let request: NSFetchRequest<Question> = Question.fetchRequest()
            request.predicate = NSPredicate(format: "text == %@", text)
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(request).first
        } catch let error {
            print(error)
            return nil
        }
    }
}
