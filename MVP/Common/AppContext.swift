//
//  UserContext.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

protocol AppContextProtocol: class {
    var accessToken: String { get set }
    var refreshToken: String { get set }
    var userData: Data? { get set }
}

class AppContext: AppContextProtocol {
    static var shared = AppContext()
    var accessToken: String = ""
    var refreshToken: String = ""
    var userData: Data?
}


