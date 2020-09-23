//
//  LoginTests.swift
//  MVPTests
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Moya
@testable import MVP

class LoginTests: QuickSpec {
    override func spec() {
        
        class LoginViewMock: LoginPresenterToView {
            var presenter: LoginViewToPresenter?
            
            var isShowLoadingCalled = false
            func showLoading() {
                isShowLoadingCalled = true
            }
            
            var isHideLoadingCalled = false
            func hideLoading() {
                isHideLoadingCalled = true
            }
            
            var isDidFailureLoginCalled = false
            func didFailureLogin(title: String, content: String) {
                isDidFailureLoginCalled = true
            }
            
            var isDidFailureValidationCalled = false
            var didFailureValidationMessage = ""
            func didFailureValidation(message: String) {
                isDidFailureLoginCalled = true
                didFailureValidationMessage = message
            }
        }
        
        class NetworkManagerServiceMock: NetworkManagerProtocol {
            var isSuccess: Bool
            init(isSuccess: Bool) {
                self.isSuccess = isSuccess
            }
            func request<T, M>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void) where T : TargetType, M : Decodable {
                let userResponse = UserResponse(data: User(id: 1, name: "Test", tenant: Tenant(id: 1, description: "Test Description", uuid: "qwertyuio2345678")))
                let authResponse = AuthResponse(accessToken: "666", refreshToken: "999")
                if isSuccess {
                    if M.self is AuthResponse.Type {
                        completion(.success(authResponse as! M))
                    } else {
                        completion(.success(userResponse as! M))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                }
            }
        }
        
        describe("LoginPresenter") {
            
            var view: LoginViewMock!
            var sut: LoginPresenter!
            
            beforeEach {
                view = LoginViewMock()
                sut = LoginPresenter()
                sut.view = view
            }
            
            context("doLogin with username and password are empty") {
                it("should call didFailureValidation") {
                    sut.doLogin(username: "", password: "")
                    expect(view.isDidFailureLoginCalled).to(beTrue())
                    expect(view.didFailureValidationMessage).to(equal("Username and Password is empty"))
                }
            }
            
            context("doLogin with username is empty") {
                it("should call didFailureValidation") {
                    sut.doLogin(username: "", password: "1234")
                    expect(view.isDidFailureLoginCalled).to(beTrue())
                    expect(view.didFailureValidationMessage).to(equal("Username is empty"))
                }
            }
            
            context("doLogin with password is empty") {
                it("should call didFailureValidation") {
                    sut.doLogin(username: "admin", password: "")
                    expect(view.isDidFailureLoginCalled).to(beTrue())
                    expect(view.didFailureValidationMessage).to(equal("Password is empty"))
                }
            }
            
            context("doLogin with there is no empty either username and password") {
                it("should call success") {
                    sut.networkManager = NetworkManager(networkServiceProtocol: NetworkManagerServiceMock(isSuccess: true))
                    sut.doLogin(username: "admin", password: "tes")
                    expect(view.isShowLoadingCalled).to(beTrue())
                    expect(view.isHideLoadingCalled).to(beTrue())
                }
            }
            
            context("doLogin with there is no empty either username and password") {
                it("should call failure") {
                    sut.networkManager = NetworkManager(networkServiceProtocol: NetworkManagerServiceMock(isSuccess: false))
                    sut.doLogin(username: "admin", password: "tes")
                    expect(view.isShowLoadingCalled).to(beTrue())
                    expect(view.isHideLoadingCalled).to(beTrue())
                }
            }
        }
    }
}
