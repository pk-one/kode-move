//
//  PopularMoviesModel.swift
//  kode-move
//
//  Created by Pavel Olegovich on 03.11.2021.
//

import Foundation

struct PopularMoviesModel: Codable {
    let results: [Results]
    
    struct Results: Codable {
        let id: Int
        let description: String
        let posterUrl: String
        let date: String
        let title: String
        let rating: Double
        
        enum CodingKeys: String, CodingKey {
            case description = "overview"
            case rating = "vote_average"
            case posterUrl = "poster_path"
            case date = "release_date"
            case id, title
        }
    }
}

