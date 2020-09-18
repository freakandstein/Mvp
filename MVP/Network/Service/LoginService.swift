//
//  LoginService.swift
//  MVP
//
//  Created by satrio.wicaksono on 18/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import Moya

enum LoginService {
    case login(request: LoginRequest)
}

extension LoginService: TargetType, AccessTokenAuthorizable {
    
    var headers: [String : String]? {
        return nil
    }
        
    var authorizationType: AuthorizationType? {
        switch self {
        case .login:
            return .bearer
        }
    }
    
    var baseURL: URL {
        let baseURL = URL(string: AppSetting.shared.infoForKey(AppSettingKey.baseURL.value))!
        return baseURL
    }

    var path: String {
        switch self {
        case .login:
            return "oauth/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        switch self {
        case .login(let request):
            let parameter = [
                "grant_type": request.grantType,
                "client_id": request.clientId,
                "client_secret": request.clientSecret,
                "username": request.username,
                "password": request.password
            ] as [String: String]
            return parameter
        }
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
