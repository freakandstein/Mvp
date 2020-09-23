//
//  LoginPresenter.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

struct EmptyResponse: Codable { }

class LoginPresenter: LoginViewToPresenter {
    var view: LoginPresenterToView?
    var networkManager: NetworkManager = NetworkManager(networkServiceProtocol: Provider(isDebugMode: true))
    var appContext: AppContextProtocol = AppContext.shared
    
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
                networkManager.request(target: targetService, model: AuthResponse.self) { [weak self] (result) in
                    switch result {
                    case .success(let response):
                        self?.appContext.accessToken = response.accessToken
                        self?.appContext.refreshToken = response.refreshToken
                        self?.getUser()
                    case .failure(let error):
                        let title = "Error"
                        let message = error.localizedDescription
                        self?.view?.didFailureLogin(title: title, content: message)
                    }
                    self?.view?.hideLoading()
                }
            }
        }
    }
    
    private func navigateToMain() {
        if let view = view as? UIViewController {
            let mainView = MainView()
            view.navigationController?.setViewControllers([mainView], animated: true)
        }
    }
    
    private func getUser() {
        let targetService = LoginService.getUser
        networkManager.request(target: targetService, model: UserResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.appContext.userData = try? JSONEncoder().encode(response)
                self?.navigateToMain()
            case .failure(let error):
                let title = "Error"
                let message = error.localizedDescription
                self?.view?.didFailureLogin(title: title, content: message)
            }
            self?.view?.hideLoading()
        }
    }
    
    func doLogin(username: String, password: String) {
        validation(username: username, password: password)
    }
}
