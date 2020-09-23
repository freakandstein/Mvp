//
//  MaterialDetailView.swift
//  MVP
//
//  Created by satrio.wicaksono on 24/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class MaterialDetailView: UIViewController {
    
    //MARK: Properties
    private let className = String(describing: MaterialDetailView.self)
    private let bundle = Bundle(for: MaterialDetailView.self)
    var presenter: MaterialDetailViewToPresenter?
    
    //MARK: IBOutlets
    
    //MARK: Initialize
    init() {
        super.init(nibName: className, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension MaterialDetailView: MaterialDetailPresenterToView {
    
}
