//
//  RawMaterialDetailResponse.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct RawMaterialDetailResponse: Codable {
    var data: RawMaterialDetail
}

struct RawMaterialDetail: Codable {
    var nameEng: String
    var supplier: Supplier
}

struct Supplier: Codable {
    var id: Int
    var name: String
    var address: String
    var contactName: String
}
