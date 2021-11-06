//
//  TimeFormatter.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import Foundation

func timeFormatter(minutes: Int) -> String {
    if minutes >= 60 {
    let (h, m) = (minutes / 60, minutes % 60)
  return "\(h) ч \(m) мин"
    } else {
        let (m) = (minutes % 60)
      return "\(m) мин"
    }
}
