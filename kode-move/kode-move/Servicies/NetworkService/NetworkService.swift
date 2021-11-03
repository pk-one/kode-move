//
//  NetworkService.swift
//  kode-move
//
//  Created by Pavel Olegovich on 03.11.2021.
//

import Foundation
import Alamofire

protocol NetworkService {
    func getPopularMovies(completion: @escaping (Result<PopularMoviesModel, Error>) ->Void )
}

class NetworkServiceImplementation: NetworkService {
    
    private let host = "https://api.themoviedb.org/3"
    private let apiKey = SessionInfo.shared.apiKey
    
    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return Session(configuration: config)
    }()

    
    func getPopularMovies(completion: @escaping (Result<PopularMoviesModel, Error>) ->Void ) {
        let path = "/discover/movie"
        let params: Parameters = [
            "sort_by" : "popularity.desc",
            "api_key" : apiKey,
            "language" : "ru-RU"
            
        ]
        session.request(host + path, method: .get, parameters: params).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data else { return }
                do {
                    let movies = try JSONDecoder().decode(PopularMoviesModel.self, from: data)
                    completion(.success(movies))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
    }
}


//switch response.result {
//case .failure(let error):
//    completionHandler(.failure(error))
//case .success(let value):
//    let json = JSON(value)
//    let fine = json.map { Fine($0, json: $1) }
//    let realmFine = fine.map { RealmFineModels($0) }
//    completionHandler(.success(realmFine))
