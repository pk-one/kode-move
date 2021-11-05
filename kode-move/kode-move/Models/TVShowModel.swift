//
//  TVShowModel.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import Foundation

struct TVShowModel: Codable {
    let id: Int
    let description: String
    let backgroundPoster: String
    let runtime: [Int]
    let name: String
    let rating: Double
    let date: String
    let genres: [Genres]
    
    struct Genres: Codable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case description = "overview"
        case backgroundPoster = "poster_path"
        case runtime = "episode_run_time"
        case date = "first_air_date"
        case rating = "vote_average"
        case id, name, genres
    }
}


