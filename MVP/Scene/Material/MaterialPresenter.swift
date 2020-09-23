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
    var rawMaterialsSearch: [RawMaterial] = []
    
    func getMaterial() {
        let targetService = MaterialService.getMaterials(storeID: storeID)
        view?.showLoading()
        networkManager.request(target: targetService, model: RawMaterialResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.rawMaterialsSearch.removeAll()
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
    
    func selectMaterial(indexPath: IndexPath) {
        let rawMaterial = rawMaterials[indexPath.row]
        if let view = view as? UIViewController {
            let materialDetailView = MaterialDetailView(uuid: rawMaterial.uuid)
            view.navigationController?.pushViewController(materialDetailView, animated: true)
        }
    }
    
    func search(keyword: String) {
        rawMaterialsSearch = rawMaterials.filter { $0.nameEng.lowercased().contains(keyword.lowercased()) }
        view?.didGetMaterials()
    }
    
    func getNumOfItems() -> Int {
        if rawMaterialsSearch.isEmpty {
            return rawMaterials.count
        } else {
            return rawMaterialsSearch.count
        }
    }
    
    func getMaterial(indexPath: IndexPath) -> RawMaterial {
        if rawMaterialsSearch.isEmpty {
            return rawMaterials[indexPath.row]
        } else {
            return rawMaterialsSearch[indexPath.row]
        }
    }
    
}
