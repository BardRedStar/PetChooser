//
//  Question+CoreDataProperties.swift
//  PetChooser
//
//  Created by Denis Kovalev on 09.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var text: String?
    @NSManaged public var probability: Set<Probability>?
}

// MARK: Generated accessors for probability
extension Question {

    @objc(addProbabilityObject:)
    @NSManaged public func addToProbability(_ value: Probability)

    @objc(removeProbabilityObject:)
    @NSManaged public func removeFromProbability(_ value: Probability)

    @objc(addProbability:)
    @NSManaged public func addToProbability(_ values: NSSet)

    @objc(removeProbability:)
    @NSManaged public func removeFromProbability(_ values: NSSet)
}
