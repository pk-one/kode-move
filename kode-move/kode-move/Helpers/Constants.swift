//
//  Constants.swift
//  kode-move
//
//  Created by Pavel Olegovich on 02.11.2021.
//

import UIKit

struct ConstantsHomeMovies {
    static let leftDistanceToCell: CGFloat = 10
    static let rightDistanceToCell: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 20
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsHomeMovies.leftDistanceToCell - ConstantsHomeMovies.rightDistanceToCell - (ConstantsHomeMovies.galleryMinimumLineSpacing / 2)) / 2.4
}

struct ConstantsHomeTVShows {
    static let leftDistanceToCell: CGFloat = 10
    static let rightDistanceToCell: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 20
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsHomeTVShows.leftDistanceToCell - ConstantsHomeTVShows.rightDistanceToCell - (ConstantsHomeTVShows.galleryMinimumLineSpacing / 2)) / 2.9
}

struct ConstantsInformation {
    static let leftDistanceToCell: CGFloat = 10
    static let rightDistanceToCell: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsInformation.leftDistanceToCell - ConstantsInformation.rightDistanceToCell - (ConstantsInformation.galleryMinimumLineSpacing / 5)) / 5.5
}
