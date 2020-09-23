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
}

protocol MaterialDetailPresenterToView: class {
    var presenter: MaterialDetailViewToPresenter? { get set }
    
}
