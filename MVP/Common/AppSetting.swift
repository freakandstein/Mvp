//
//  AppSetting.swift
//  MVP
//
//  Created by satrio.wicaksono on 18/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

enum AppSettingKey: String {
    case config = "Config"
    case baseURL = "BaseURL"
    case bearerToken = "BearerToken"
    
    var value: String {
        return rawValue
    }
}

protocol AppSettingProtocol {
    func infoForKey(_ key: String, defaultValue: String) -> String
}

class AppSettingDelegate: AppSettingProtocol {
    func infoForKey(_ key: String, defaultValue: String) -> String {
        let dictionary = Bundle.main.infoDictionary?[AppSettingKey.config.value] as? NSDictionary
        if let value = (dictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "") {
            return value
        } else {
            return defaultValue
        }
    }
}

class AppSetting {
    static let shared = AppSetting()
    private var delegate: AppSettingProtocol?
    
    init(appSettingDelegate: AppSettingProtocol = AppSettingDelegate()) {
        delegate = appSettingDelegate
    }
    
    public func infoForKey(_ key: String, defaultValue: String = "") -> String {
        return delegate?.infoForKey(key, defaultValue: defaultValue) ?? ""
    }
}
