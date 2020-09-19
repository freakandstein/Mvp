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
}

protocol MainPresenterToView {
    var presenter: MainViewToPresenter? { get set }
}
