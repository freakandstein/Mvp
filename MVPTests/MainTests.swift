//
//  MainTests.swift
//  MVPTests
//
//  Created by satrio.wicaksono on 20/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Moya
@testable import MVP

class MainTests: QuickSpec {
    override func spec() {
        
        class MainViewMock: MainPresenterToView {
            var presenter: MainViewToPresenter?
            
            var isDidGetStoresCalled = false
            func didGetStores() {
                isDidGetStoresCalled = true
            }
            
            var isFailureGetStoresCalled = false
            func failureGetStores(title: String, message: String) {
                isFailureGetStoresCalled = true
            }
            
            var isHideLoadingCalled = false
            func hideLoading() {
                isHideLoadingCalled = true
            }
            
            var isShowLoadingCalled = false
            func showLoading() {
                isShowLoadingCalled = true
            }
        }
        
        class NetworkManagerServiceMock: NetworkManagerProtocol {
            var isSuccess: Bool
            init(isSuccess: Bool) {
                self.isSuccess = isSuccess
            }
            func request<T, M>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void) where T : TargetType, M : Decodable {
                let storesResponse = StoresResponse(data: [StoreResponse(id: 1, uuid: "999", name: "Test")])
                if isSuccess {
                    completion(.success(storesResponse as! M))
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                }
            }
        }
        
        describe("MainPresenter") {
            var view: MainViewMock!
            var sut: MainPresenter!
            
            beforeEach {
                view = MainViewMock()
                sut = MainPresenter()
                sut.view = view
            }
            
            context("getStore with success") {
                it("should call success") {
                    sut.networkManager = NetworkManager(networkServiceProtocol: NetworkManagerServiceMock(isSuccess: true))
                    sut.getStores()
                    expect(view.isShowLoadingCalled).to(beTrue())
                    expect(view.isHideLoadingCalled).to(beTrue())
                }
            }
            
            context("getStore with failure") {
                it("should call failure") {
                    sut.networkManager = NetworkManager(networkServiceProtocol: NetworkManagerServiceMock(isSuccess: false))
                    sut.getStores()
                    expect(view.isShowLoadingCalled).to(beTrue())
                    expect(view.isHideLoadingCalled).to(beTrue())
                }
            }
        }
    }
}
