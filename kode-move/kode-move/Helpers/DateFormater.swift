//
//  TimeForm.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import Foundation

func dateFormatedHome(from: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.locale = Locale(identifier: "ru_RU")
    dateFormatterPrint.dateFormat = "dd MMM yyyy"
    let date = dateFormatterGet.date(from: from)
    let finalDate =  dateFormatterPrint.string(from: date ?? Date())
    
    return finalDate
}

func dateFormatedInfo(from: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.locale = Locale(identifier: "ru_RU")
    dateFormatterPrint.dateFormat = "yyyy"
    let date = dateFormatterGet.date(from: from)
    let finalDate =  dateFormatterPrint.string(from: date ?? Date())
    
    return finalDate
}
