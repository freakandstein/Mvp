//
//  MaterialService.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import Moya

enum MaterialService {
    case getMaterials(storeID: String)
}

extension MaterialService: TargetType, AccessTokenAuthorizable {
    
    var headers: [String : String]? {
        return nil
    }
        
    var authorizationType: AuthorizationType? {
        switch self {
        case .getMaterials:
            return .bearer
        }
    }
    
    var baseURL: URL {
        var stringURL = AppSetting.shared.infoForKey(AppSettingKey.baseURL.value)
        switch self {
        case .getMaterials(let storeID):
            stringURL += "/raw-materials?storeId=\(storeID)"
        }
        let baseURL = URL(string: stringURL)!
        return baseURL
    }

    var path: String {
        switch self {
        case .getMaterials:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMaterials:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMaterials:
            return .requestPlain
        }
    }
}
