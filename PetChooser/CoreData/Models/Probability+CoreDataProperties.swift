//
//  Probability+CoreDataProperties.swift
//  PetChooser
//
//  Created by Denis Kovalev on 09.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//
//

import Foundation
import CoreData


extension Probability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Probability> {
        return NSFetchRequest<Probability>(entityName: "Probability")
    }

    @NSManaged public var plus: Double
    @NSManaged public var minus: Double
    @NSManaged public var pet: Pet?
    @NSManaged public var question: Question?

}
