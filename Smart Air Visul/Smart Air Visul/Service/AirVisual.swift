//
//  AirVisual.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 18/12/2562 BE.
//  Copyright © 2562 Nutnutcha Hanggitthagul. All rights reserved.
//
//https://api.airvisual.com/v2/city?city=BangBuaThong&state=Nonthaburi&country=Thailand&key=383b8c61-a881-4ff2-8c46-e1f9116421cc

import Moya

enum AirVisual {
    case citiData(city: String, state: String)
    case states
    case cities(state: String)
    
}

extension AirVisual: TargetType {
    var baseURL: URL { return URL(string: "https://api.airvisual.com")! }
    
    var path: String {
        switch self {
        case .citiData:
            return "/v2/city"
        case .states:
            return "/v2/states"
        case .cities(_):
            return "/v2/cities"
        }
    }
    
    var method: Moya.Method {
            return .get
    }
    
    var task: Task {
        switch self {
        case let.citiData(city, state):
            return .requestParameters(parameters: ["city": city, "state": state,"country": "Thailand", "key": "383b8c61-a881-4ff2-8c46-e1f9116421cc"], encoding: URLEncoding.queryString)
        case .states:
            return .requestParameters(parameters: ["country": "Thailand","key": "383b8c61-a881-4ff2-8c46-e1f9116421cc"], encoding: URLEncoding.queryString)
        case let .cities(state):
            return .requestParameters(parameters: ["state": state, "country": "Thailand", "key": "383b8c61-a881-4ff2-8c46-e1f9116421cc"], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


