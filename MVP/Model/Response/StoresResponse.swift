//
//  StoresResponse.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct StoresResponse: Codable {
    var data: [StoreResponse]
}

struct StoreResponse: Codable {
    var id: Int
    var uuid: String
    var name: String
}
