//
//  MovieModel.swift
//  kode-move
//
//  Created by Pavel Olegovich on 05.11.2021.
//

import Foundation

struct MovieModel: Codable {
    let id: Int
    let description: String
    let backgroundPoster: String
    let date: String
    let runtime: Int
    let title: String
    let rating: Double
    let genres: [Genres]
  
    struct Genres: Codable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case description = "overview"
        case backgroundPoster = "poster_path"
        case date = "release_date"
        case rating = "vote_average"
        case id, title, runtime, genres
    }
}

