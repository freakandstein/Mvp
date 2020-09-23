//
//  MaterialDetailProtocols.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation

protocol MaterialDetailViewToPresenter: class {
    var view: MaterialDetailPresenterToView? { get set }
    var networkManager: NetworkManager { get set }
    var uuid: String { get set }
    
    func getMaterialDetail()
}

protocol MaterialDetailPresenterToView: class {
    var presenter: MaterialDetailViewToPresenter? { get set }
    
    func hideLoading()
    func showLoading()
    func didGetMaterialDetail(data: RawMaterialDetail)
    func failureGetMaterialDetail(title: String, message: String)
}
