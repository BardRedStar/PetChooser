//
//  MainControllerViewModel.swift
//  PetChooser
//
//  Created by Denis Kovalev on 16.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation
import CoreData

enum Answer: String, CaseIterable {
    case yes = "Absolutely Yes"
    case probablyYes = "Probably Yes"
    case dontKnow = "I don't know"
    case probablyNot = "Probably Not"
    case no = "Absolutely Not"

    var probability: Double {
        switch self {
        case .yes: return 1.0
        case .probablyYes: return 0.75
        case .dontKnow: return 0.5
        case .probablyNot: return 0.25
        case .no: return 0.0
        }
    }
}

class MainControllerViewModel {

    var items: [QuestionViewModel] = []

    var currentPage: Int = 0

    func loadData() {
        items = Question.allQuestions().map{ QuestionViewModel(questionText: $0.text!) }
    }
}
