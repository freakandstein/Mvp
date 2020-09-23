//
//  MaterialPresenter.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class MaterialPresenter: MaterialViewToPresenter {
    var view: MaterialPresenterToView?
    var storeID: String = ""
    var networkManager: NetworkManager = NetworkManager(networkServiceProtocol: Provider(isDebugMode: true))
    var rawMaterials: [RawMaterial] = []
    
    func getMaterial() {
        let targetService = MaterialService.getMaterials(storeID: storeID)
        view?.showLoading()
        networkManager.request(target: targetService, model: RawMaterialResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.rawMaterials = response.data
                self?.view?.didGetMaterials()
            case .failure(let error):
                let title = "Error"
                let message = error.localizedDescription
                self?.view?.failureGetMaterials(title: title, message: message)
            }
            self?.view?.hideLoading()
        }
    }
}
