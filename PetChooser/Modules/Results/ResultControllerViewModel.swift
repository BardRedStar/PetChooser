//
//  ResultControllerViewModel.swift
//  PetChooser
//
//  Created by Denis Kovalev on 08.01.2020.
//  Copyright © 2020 10X. All rights reserved.
//

import Foundation

class ResultControllerViewModel {

    var testResults: [Answer] = []

    func calculateResult() -> String {

        let answerProbabilities = testResults.map { $0.probability }

        let pets = Pet.allPets()

        let p = 1 / Double(pets.count)

        pets.map { pet -> Double in
            var positive = p
            var negative = p
            Probability.probabilitiesForPetWith(name: pet.name!).forEach { probability in
                positive = calculatePositive(p: positive, plus: probability.plus, minus: probability.minus)
                negative = calculateNegative(p: negative, plus: probability.plus, minus: probability.minus)
            }
            return positive * answerProbabilities
        }

        return "test"
    }

    private func calculatePositive(p: Double, plus: Double, minus: Double) -> Double {
        return (plus * p) / ((plus * p) + minus * (1 - p))
    }

    private func calculateNegative(p: Double, plus: Double, minus: Double) -> Double {
        return ((1 - plus) * p) / (((1 - plus) * p) + (1 - minus) * (1 - p))
    }
}
