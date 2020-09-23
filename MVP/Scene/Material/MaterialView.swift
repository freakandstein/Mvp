//
//  MaterialView.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MaterialView: UIViewController {
    //MARK: Properties
    private let className = String(describing: MaterialView.self)
    private let bundle = Bundle(for: MaterialView.self)
    private let disposeBag = DisposeBag()
    private var loadingView: UILoadingView?
    private var errorView: BottomOverlayView?
    private var refreshControl: UIRefreshControl!
    var presenter: MaterialViewToPresenter?
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        searchBar.rx.text.orEmpty.asDriver()
            .debounce(.milliseconds(300))
            .drive(onNext: { [weak self] (text) in
                self?.presenter?.search(keyword: text)
            }).disposed(by: disposeBag)
        presenter?.getMaterial(isRefresh: false)
    }
    
    @objc private func pullRefresh() {
        presenter?.getMaterial(isRefresh: true)
    }
}

extension MaterialView: MaterialPresenterToView {
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
        refreshControl.endRefreshing()
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
        guard let presenter = presenter else { return .zero }
        return presenter.getNumOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let data = presenter.getMaterialByIndex(indexPath: indexPath)
        cell.textLabel?.text = data.nameEng
        presenter.loadMore(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectMaterial(indexPath: indexPath)
    }
}
