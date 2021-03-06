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
    var networkManager: NetworkManager { get set }
    var stores: [StoreResponse] { get set }
    var appContext: AppContextProtocol { get set }
    
    func getStores()
    func doLogout()
    func selectStore(indexPath: IndexPath)
}

protocol MainPresenterToView {
    var presenter: MainViewToPresenter? { get set }
    
    func showLoading()
    func hideLoading()
    func didGetStores()
    func failureGetStores(title: String, message: String)
}
