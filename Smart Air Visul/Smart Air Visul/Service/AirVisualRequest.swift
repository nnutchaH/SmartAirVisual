//
//  Network.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 6/12/2562 BE.
//  Copyright © 2562 Nutnutcha Hanggitthagul. All rights reserved.
//



import Foundation
import Moya

class AirVisualRequest {
    let provider = MoyaProvider<AirVisual>()
    
    func requestCitiData(city: String, state: String, callback: ((Result<AirVisualData, Error>) -> Void)?) {
        provider
            .request(
            .citiData(city: city, state: state)) { result in
                switch result {
                case .success(let response):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    do {
                        let data = try jsonDecoder.decode(AirVisualData.self, from: response.data)
                        callback?(.success(data))
                    } catch {
                        callback?(.failure(error))
                    }
                case .failure(let error):
                    callback?(.failure(error))
                }
        }
    }
    
    func requestStatesData(callback: ((Result<StatesData, Error>) -> Void)?) {
        provider
            .request(
            .states ) { result in
                switch result {
                case .success(let response):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    do {
                        let data = try jsonDecoder.decode(StatesData.self, from: response.data)
                        callback?(.success(data))
                    } catch {
                        callback?(.failure(error))
                    }
                case .failure(let error):
                    callback?(.failure(error))
                }
        }
    }
    
    func requestCitiesData(state: String, callback: ((Result<CitiesData, Error>) -> Void)?) {
        provider
            .request(
            .cities(state: state)) { result in
                switch result {
                case .success(let response):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    do {
                        let data = try jsonDecoder.decode(CitiesData.self, from: response.data)
                        callback?(.success(data))
                    } catch {
                        callback?(.failure(error))
                    }
                case .failure(let error):
                    callback?(.failure(error))
                }
        }
    }
}





