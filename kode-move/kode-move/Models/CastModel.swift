//
//  CastModel.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import Foundation

struct CastModel: Codable {
    let cast: [Cast]
    
    struct Cast: Codable {
        let id: Int
        let name: String
        let avatar: String?
        let character: String
        
        enum CodingKeys: String, CodingKey {
            case avatar = "profile_path"
            case id, name, character
        }
    }
}


