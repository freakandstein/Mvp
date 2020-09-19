//
//  MainPresenter.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: MainViewToPresenter {
    var view: MainPresenterToView?
    var stores: [StoreResponse] = []
    
    func getStores() {
        view?.showLoading()
        let targetService = StoreService.getStores
        NetworkManager.shared.request(target: targetService, model: StoresResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.stores = response.data
                self?.view?.didGetStores()
            case .failure(let error):
                let title = "Error"
                let message = error.localizedDescription
                self?.view?.failureGetStores(title: title, message: message)
            }
            self?.view?.hideLoading()
        }
    }
    
    func doLogout() {
        if let view = view as? UIViewController {
            let loginView = LoginView()
            view.navigationController?.setViewControllers([loginView], animated: true)
        }
    }
}
