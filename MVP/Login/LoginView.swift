//
//  LoginView.swift
//  MVP
//
//  Created by satrio.wicaksono on 18/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: LoginView.self)
    private let className = String(describing: LoginView.self)
    
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
