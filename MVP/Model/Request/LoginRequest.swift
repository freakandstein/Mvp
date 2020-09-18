//
//  LoginRequest.swift
//  MVP
//
//  Created by satrio.wicaksono on 18/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct LoginRequest {
    var grantType: String
    var clientId: String
    var clientSecret: String
    var username: String
    var password: String
    
    init() {
        self.grantType = ""
        self.clientId = ""
        self.clientSecret = ""
        self.username = ""
        self.password = ""
    }
}
