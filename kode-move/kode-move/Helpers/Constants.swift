//
//  Constants.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

struct Constants {
    static let leftDistanceToCell: CGFloat = 10
    static let rightDistanceToCell: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToCell - Constants.rightDistanceToCell - (Constants.galleryMinimumLineSpacing / 2)) / 2.3
}
