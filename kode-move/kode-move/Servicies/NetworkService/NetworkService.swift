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
    func getPopularTVShows(completion: @escaping (Result<PopularTVShowsModel, Error>) ->Void )
    func getMovie(id: Int, completion: @escaping (Result<MovieModel, Error>) ->Void )
    func getTVShow(id: Int, completion: @escaping (Result<TVShowModel, Error>) ->Void )
    func getCast(id: Int, from: getFrom , completion: @escaping (Result<CastModel, Error>) ->Void )
}

enum getFrom: String {
    case movie
    case tv
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
    
    func getPopularTVShows(completion: @escaping (Result<PopularTVShowsModel, Error>) ->Void ) {
        let path = "/discover/tv"
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
                    let tvShows = try JSONDecoder().decode(PopularTVShowsModel.self, from: data)
                    completion(.success(tvShows))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
    }
    
    func getMovie(id: Int, completion: @escaping (Result<MovieModel, Error>) ->Void ) {
        let path = "/movie/\(id)"
        let params: Parameters = [
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
                    let movie = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(.success(movie))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
    }
    
    func getTVShow(id: Int, completion: @escaping (Result<TVShowModel, Error>) ->Void ) {
        let path = "/tv/\(id)"
        let params: Parameters = [
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
                    let tvShow = try JSONDecoder().decode(TVShowModel.self, from: data)
                    completion(.success(tvShow))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
    }
    
    func getCast(id: Int, from: getFrom , completion: @escaping (Result<CastModel, Error>) ->Void ) {
        let path = "/\(from)/\(id)/credits"
        let params: Parameters = [
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
                    let casts = try JSONDecoder().decode(CastModel.self, from: data)
                    completion(.success(casts))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
    }
}
