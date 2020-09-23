//
//  UserResponse.swift
//  MVP
//
//  Created by satrio.wicaksono on 23/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    var data: User
}

struct User: Codable {
    var id: Int
    var name: String
    var tenant: Tenant
}

struct Tenant: Codable {
    var id: Int
    var description: String
    var uuid: String
}
