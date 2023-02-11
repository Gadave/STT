//
//  SystemDesign.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

enum SystemDesign {
    enum Colors {
        static let black = UIColor(cgColor: CGColor(red: 49 / 255,
                                                    green: 49 / 255,
                                                    blue: 49 / 255,
                                                    alpha: 1))
        static let gray = UIColor(cgColor: CGColor(red: 243 / 255,
                                                   green: 243 / 255,
                                                   blue: 245 / 255,
                                                   alpha: 1))
        static let gray2 = UIColor(cgColor: CGColor(red: 150 / 255,
                                                    green: 149 / 255,
                                                    blue: 155 / 255,
                                                    alpha: 1))
    }
    
    enum Fonts {
        static let huge = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let big = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let middle = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let small = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    enum viewConfigurations {
        static let padding: CGFloat = 20
        static let spacing: CGFloat = 12
    }
    
    
}
