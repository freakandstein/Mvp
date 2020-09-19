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
    
    func getMaterial() {
        let targetService = MaterialService.getMaterials(storeID: storeID)
        view?.showLoading()
        NetworkManager.shared.request(target: targetService, model: EmptyResponse.self) { [weak self] (result) in
            switch result {
            case .success:
                print("#Success")
            case .failure(let error):
                let title = "Error"
                let message = error.localizedDescription
                self?.view?.failureGetMaterials(title: title, message: message)
            }
            self?.view?.hideLoading()
        }
    }
}
