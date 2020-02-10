//
//  Pet+Extension.swift
//  PetChooser
//
//  Created by Denis Kovalev on 16.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

extension Pet {

    class func allPets() -> [Pet] {
        do {
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(Pet.fetchRequest())
        } catch let error {
            print(error)
            return []
        }
    }

    class func petWith(name: String) -> Pet? {
        do {
            let request: NSFetchRequest<Pet> = Pet.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", name)
            return try CoreDataManager.instance.persistentContainer.viewContext.fetch(request).first
        } catch let error {
            print(error)
            return nil
        }
    }
}
