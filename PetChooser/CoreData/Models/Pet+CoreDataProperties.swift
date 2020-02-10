//
//  Pet+CoreDataProperties.swift
//  PetChooser
//
//  Created by Denis Kovalev on 09.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String?
    @NSManaged public var probability: Set<Probability>?
}

// MARK: Generated accessors for probability
extension Pet {

    @objc(addProbabilityObject:)
    @NSManaged public func addToProbability(_ value: Probability)

    @objc(removeProbabilityObject:)
    @NSManaged public func removeFromProbability(_ value: Probability)

    @objc(addProbability:)
    @NSManaged public func addToProbability(_ values: NSSet)

    @objc(removeProbability:)
    @NSManaged public func removeFromProbability(_ values: NSSet)

}
