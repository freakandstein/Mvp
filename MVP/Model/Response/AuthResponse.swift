//
//  AuthResponse.swift
//  MVP
//
//  Created by satrio.wicaksono on 23/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct AuthResponse: Codable {
    var accessToken: String
    var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
