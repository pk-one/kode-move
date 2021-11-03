//
//  Constants.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

struct ConstantsHome {
    static let leftDistanceToCell: CGFloat = 10
    static let rightDistanceToCell: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsHome.leftDistanceToCell - ConstantsHome.rightDistanceToCell - (ConstantsHome.galleryMinimumLineSpacing / 2)) / 2.3
}

struct ConstantsInformation {
    static let leftDistanceToCell: CGFloat = 10
    static let rightDistanceToCell: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsHome.leftDistanceToCell - ConstantsHome.rightDistanceToCell - (ConstantsHome.galleryMinimumLineSpacing / 5)) / 5.5
}
