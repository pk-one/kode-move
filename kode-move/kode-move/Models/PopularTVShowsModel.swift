//
//  PopularTVShowsModel.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import Foundation

struct PopularTVShowsModel: Codable {
    let results: [Results]
    
    struct Results: Codable {
        let id: Int
        let description: String
        let posterUrl: String
        let date: String
        let name: String
        let rating: Double
        
        enum CodingKeys: String, CodingKey {
            case description = "overview"
            case rating = "vote_average"
            case posterUrl = "poster_path"
            case date = "first_air_date"
            case id, name
        }
    }
}

