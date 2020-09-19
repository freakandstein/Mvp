//
//  MainView.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIViewController {
    
    //MARK: Properties
    private let className = String(describing: MainView.self)
    private let bundle = Bundle(for: MainView.self)
    var presenter: MainViewToPresenter?
    
    //MARK: IBOutlets
    
    //MARK: Initialize
    init() {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = MainPresenter()
        view.presenter = presenter
        presenter.view = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension MainView: MainPresenterToView {
    
}
