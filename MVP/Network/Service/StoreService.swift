//
//  StoreService.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import Moya

enum StoreService {
    case getStores
}

extension StoreService: TargetType, AccessTokenAuthorizable {
    
    var headers: [String : String]? {
        return nil
    }
        
    var authorizationType: AuthorizationType? {
        switch self {
        case .getStores:
            return .bearer
        }
    }
    
    var baseURL: URL {
        let baseURL = URL(string: AppSetting.shared.infoForKey(AppSettingKey.baseURL.value))!
        return baseURL
    }

    var path: String {
        switch self {
        case .getStores:
            return "stores"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getStores:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getStores:
            return .requestPlain
        }
    }
}
