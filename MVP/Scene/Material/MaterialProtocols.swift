//
//  MaterialProtocols.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

protocol MaterialViewToPresenter {
    var view: MaterialPresenterToView? { get set }
    var networkManager: NetworkManager { get set }
    var storeID: String { get set }
    var rawMaterials: [RawMaterial] { get set }
    
    func getMaterial()
    func selectMaterial(indexPath: IndexPath)
}

protocol MaterialPresenterToView {
    var presenter: MaterialViewToPresenter? { get set }
    
    func hideLoading()
    func showLoading()
    func didGetMaterials()
    func failureGetMaterials(title: String, message: String)
}
