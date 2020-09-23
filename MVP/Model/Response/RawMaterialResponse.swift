//
//  RawMaterialResponse.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct RawMaterialResponse: Codable {
    var data: [RawMaterial]
}

struct RawMaterial: Codable {
    var id: Int
    var nameEng: String
    var uuid: String
}
