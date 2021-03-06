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
    case getUser
}

extension LoginService: TargetType, AccessTokenAuthorizable {
    
    var headers: [String : String]? {
        return nil
    }
        
    var authorizationType: AuthorizationType? {
        switch self {
        case .login, .getUser:
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
        case .getUser:
            return "users/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getUser:
            return .get
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
        case .getUser:
            return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getUser:
            return .requestPlain
        }
    }
}
