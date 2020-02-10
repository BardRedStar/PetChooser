//
//  ContentType.swift
//  PetChooser
//
//  Created by Denis Kovalev on 12.12.2019.
//  Copyright © 2019 10X. All rights reserved.
//

import Foundation

enum ContentType: String {
    case pets = "Pets"
    case questions = "Questions"

    var title: String {
        switch self {
        case .pets:
            return "Pet name"
        case .questions:
            return "Question text"
        }
    }
}
