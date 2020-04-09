//
//  StatesData.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 25/12/2562 BE.
//  Copyright © 2562 Nutnutcha Hanggitthagul. All rights reserved.
//

import Foundation

struct StatesData: Codable {
    let status: String
    let data: [State]
}
struct State: Codable {
    let state: String
}
