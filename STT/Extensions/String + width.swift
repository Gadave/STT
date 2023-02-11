//
//  String + width.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

extension String {
    public func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    
}

