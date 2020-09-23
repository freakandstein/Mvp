//
//  NetworkManager.swift
//  MVP
//
//  Created by satrio.wicaksono on 18/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import Moya

protocol NetworkManagerProtocol: class {
    func request<T: TargetType, M: Decodable>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void)
}

class Provider: NetworkManagerProtocol {
    
    private var provider: MoyaProvider<MultiTarget>?
    private var isDebug: Bool
    private var appContext: AppContextProtocol = AppContext.shared
    
    init(isDebugMode: Bool = false) {
        if appContext.accessToken.isEmpty {
            appContext.accessToken = AppSetting.shared.infoForKey(AppSettingKey.bearerToken.value)
        }
        isDebug = isDebugMode
        let authPlugin = AccessTokenPlugin { [unowned self] _ in self.appContext.accessToken  }
        if isDebug {
            provider = MoyaProvider<MultiTarget>(plugins: [authPlugin, NetworkLoggerPlugin()])
        } else {
            provider = MoyaProvider<MultiTarget>(plugins: [authPlugin])
        }
    }
    
    public func request<T, M>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void) where T : TargetType, M : Decodable {
        self.provider?.request(MultiTarget(target)) { [unowned self] (result) in
            switch result {
            case .success(let response):
                do {
                    if self.isDebug {
                        let jsonObject = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                        print(jsonObject)
                    }
                    if response.statusCode == 400 {
                        let errorResponse = try response.map(ErrorResponse.self)
                        let errorData = NSError(domain: errorResponse.message, code: response.statusCode, userInfo: nil)
                        completion(.failure(errorData))
                    } else {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let result = try filteredResponse.map(model)
                        completion(.success(result))
                    }
                } catch(let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class NetworkManager {
    
    private var delegate: NetworkManagerProtocol?
    
    init(networkServiceProtocol: NetworkManagerProtocol = Provider()) {
        self.delegate = networkServiceProtocol
    }
    
    public func request<T: TargetType, M: Decodable>(target: T, model modelType: M.Type, completion: @escaping (Result<M, Error>) -> Void ){
        self.delegate?.request(target: target, model: modelType, completion: completion)
    }
}
