//
//  UserContext.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

protocol AppContextProtocol: class {
    var userData: Data? { get set }
}

class AppContext: AppContextProtocol {
    static var shared = AppContext()
    var userData: Data?
}


