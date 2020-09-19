//
//  LoginPresenter.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

struct EmptyResponse: Codable { }

class LoginPresenter: LoginViewToPresenter {
    var view: LoginPresenterToView?
    
    private func validation(username: String, password: String) {
        if username.isEmpty && password.isEmpty {
            view?.didFailureValidation(message: "Username and Password is empty")
        } else {
            if username.isEmpty {
                view?.didFailureValidation(message: "Username is empty")
            } else if password.isEmpty {
                view?.didFailureValidation(message: "Password is empty")
            } else {
                view?.showLoading()
                var request = LoginRequest()
                request.username = username
                request.password = password
                request.grantType = "password"
                request.clientId = AppSetting.shared.infoForKey(AppSettingKey.clientID.value)
                request.clientSecret = AppSetting.shared.infoForKey(AppSettingKey.clientSecret.value)
                let targetService = LoginService.login(request: request)
                NetworkManager.shared.request(target: targetService, model: EmptyResponse.self) { [weak self] (result) in
                    switch result {
                    case .success:
                        print("#Success")
                    case .failure(let error):
                        print("#\(error)")
                    }
                    self?.view?.hideLoading()
                }
            }
        }
    }
    
    func doLogin(username: String, password: String) {
        validation(username: username, password: password)
    }
}
