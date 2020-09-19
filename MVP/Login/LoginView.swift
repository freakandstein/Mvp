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
    private var loadingView: UILoadingView?
    var presenter: LoginViewToPresenter?
    
    //MARK: IBOutlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //MARK: Initialize
    init() {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = LoginPresenter()
        view.presenter = presenter
        presenter.view = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped() {
        let username = usernameField?.text ?? ""
        let password = passwordField?.text ?? ""
        presenter?.doLogin(username: username, password: password)
    }
}

extension LoginView: LoginPresenterToView {
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
    
    func showLoading() {
        loadingView = UILoadingView(frame: self.view.bounds)
        guard let loadingView = loadingView else { return }
        self.view.addSubview(loadingView)
    }
    
    func didSuccessLogin() {
        
    }
    
    func didFailureLogin() {
        
    }
    
    func didFailureValidation(message: String) {
        let errorView = BottomOverlayView(frame: self.view.bounds, title: "Validation Failure", content: message)
        self.view.addSubview(errorView)
    }
}
