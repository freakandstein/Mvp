//
//  LoginProtocols.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

protocol LoginViewToPresenter {
    var view: LoginPresenterToView? { get set }
    
    func doLogin(username: String, password: String)
}

protocol LoginPresenterToView {
    var presenter: LoginViewToPresenter? { get set }
    
    func showLoading()
    func hideLoading()
    func didFailureLogin(title: String, content: String)
    func didFailureValidation(message: String)
}
