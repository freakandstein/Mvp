//
//  MainProtocols.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

protocol MainViewToPresenter {
    var view: MainPresenterToView? { get set }
    var stores: [StoreResponse] { get set }
    
    func getStores()
    func doLogout()
}

protocol MainPresenterToView {
    var presenter: MainViewToPresenter? { get set }
    
    func showLoading()
    func hideLoading()
    func didGetStores()
    func failureGetStores(title: String, message: String)
}
