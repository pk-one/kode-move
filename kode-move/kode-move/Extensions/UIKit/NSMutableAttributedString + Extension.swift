//
//  NSMutableAttributedString + Extension.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import Foundation
import UIKit

extension NSMutableAttributedString {

    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}
