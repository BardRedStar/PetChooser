//
//  ShowControllerViewModel.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

class ShowControllerViewModel: EntityControllerViewModel {

    var entityTitle: String?
    var contentType: ContentType?

    override func loadData() {
        let probabilities = (contentType == .pets) ?
            Probability.probabilitiesForPetWith(name: entityTitle!) :
            Probability.probabilitiesForQuestionsWith(text: entityTitle!)
        items = probabilities.map{ EntityViewModel(plus: $0.plus, minus: $0.minus,
                                                   name: (contentType == .pets) ? $0.question!.text! : $0.pet!.name!)}
    }
}
