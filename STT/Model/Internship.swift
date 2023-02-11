//
//  Internship.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import Foundation

enum Internship: String, Equatable {
    case IOS
    case Android
    case Design
    case Flutter
    case QA
    case PB
    case Frontend
    case Backend
    case Project
    case Product
    case none
}

extension Internship: CaseIterable {
    static var allCases: [Internship] {
        [.IOS,
         .Android,
         .Design,
         .Flutter,
         .QA,
         .PB,
         .Frontend,
         .Backend,
         .Project,
         .Product]
    }
    
    
}
