//
//  ErrorResponse.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var type: String
    var `class`: String
    var message: String
}
