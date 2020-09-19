//
//  MaterialView.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class MaterialView: UIViewController {
    //MARK: Properties
    private let className = String(describing: MaterialView.self)
    private let bundle = Bundle(for: MaterialView.self)
    private var loadingView: UILoadingView?
    private var errorView: BottomOverlayView?
    var presenter: MaterialViewToPresenter?
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Initialize
    init(storeID: String) {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = MaterialPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.storeID = storeID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMaterial()
    }
}

extension MaterialView: MaterialPresenterToView {
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
    
    func showLoading() {
        loadingView = UILoadingView(frame: self.view.bounds)
        guard let loadingView = loadingView else { return }
        self.view.addSubview(loadingView)
    }
    
    func failureGetMaterials(title: String, message: String) {
        errorView = BottomOverlayView(frame: self.view.bounds, title: title, content: message)
        if let errorView = errorView {
            self.view.addSubview(errorView)
        }
    }
    
    func didGetMaterials() {
        tableView.reloadData()
    }
}

extension MaterialView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
