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
    private var loadingView: UILoadingView?
    private var errorView: BottomOverlayView?
    var presenter: MainViewToPresenter?
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
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
        presenter?.getStores()
    }
}

extension MainView: MainPresenterToView {
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
    
    func showLoading() {
        loadingView = UILoadingView(frame: self.view.bounds)
        guard let loadingView = loadingView else { return }
        self.view.addSubview(loadingView)
    }
    
    func didGetStores() {
        tableView.reloadData()
    }
    
    func failureGetStores(title: String, message: String) {
        errorView = BottomOverlayView(frame: self.view.bounds, title: title, content: message)
        if let errorView = errorView {
            self.view.addSubview(errorView)
        }
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.stores.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let data = presenter.stores[indexPath.row]
        cell.textLabel?.text = data.name
        return cell
    }
    
    
}
