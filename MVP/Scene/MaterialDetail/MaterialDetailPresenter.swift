//
//  MaterialDetailPresenter.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

class MaterialDetailPresenter: MaterialDetailViewToPresenter {
    var view: MaterialDetailPresenterToView?
    var uuid: String = ""
    var networkManager: NetworkManager = NetworkManager(networkServiceProtocol: Provider(isDebugMode: true))
    
    func getMaterialDetail() {
        let targetService = MaterialService.getMaterialDetail(uuid: uuid)
        view?.showLoading()
        networkManager.request(target: targetService, model: RawMaterialDetailResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.view?.didGetMaterialDetail(data: response.data)
            case .failure(let error):
                let title = "Error"
                let message = error.localizedDescription
                self?.view?.failureGetMaterialDetail(title: title, message: message)
            }
            self?.view?.hideLoading()
        }
    }
}
