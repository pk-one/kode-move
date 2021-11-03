//
//  UIViewController + Extension.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

extension UIViewController {
    func createCustomBarButtonItem(selector: Selector, title: String, image: String, enabled: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: image), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 0.968627451, green: 1, blue: 1, alpha: 1)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        if enabled == true {
            button.isUserInteractionEnabled = true
            button.tintColor = #colorLiteral(red: 0.968627451, green: 1, blue: 1, alpha: 1)
        } else {
            button.isUserInteractionEnabled = false
            button.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    func createCustomLogoBarButtonItem(image: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
