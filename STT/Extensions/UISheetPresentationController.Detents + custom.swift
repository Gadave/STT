//
//  UISheetPresentationController.Detents + custom.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

extension UISheetPresentationController.Detent {
    static var customSmall: UISheetPresentationController.Detent {
        return .custom(identifier: Identifier("CustomSmall")) { context in
            0.41 * context.maximumDetentValue
        }
    }
    
    static var customMiddle: UISheetPresentationController.Detent {
        return .custom(identifier: Identifier("CustomMiddle")) { context in
            0.63 * context.maximumDetentValue
        }
    }
    
    static var customBig: UISheetPresentationController.Detent {
        return .custom(identifier: Identifier("CustomBig")) { context in
            0.99 * context.maximumDetentValue
        }
    }
    
    
}
