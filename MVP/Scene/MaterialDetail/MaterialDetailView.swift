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
    private var loadingView: UILoadingView?
    private var errorView: BottomOverlayView?
    var presenter: MaterialDetailViewToPresenter?
    
    //MARK: IBOutlets
    @IBOutlet weak var materialDetailNameLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var supplierAddressLabel: UILabel!
    @IBOutlet weak var supplierContactLabel: UILabel!
    
    //MARK: Initialize
    init(uuid: String) {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = MaterialDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.uuid = uuid
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMaterialDetail()
    }
}
extension MaterialDetailView: MaterialDetailPresenterToView {
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
    
    func showLoading() {
        loadingView = UILoadingView(frame: self.view.bounds)
        guard let loadingView = loadingView else { return }
        self.view.addSubview(loadingView)
    }
    
    func failureGetMaterialDetail(title: String, message: String) {
        errorView = BottomOverlayView(frame: self.view.bounds, title: title, content: message)
        if let errorView = errorView {
            self.view.addSubview(errorView)
        }
    }
    
    func didGetMaterialDetail(data: RawMaterialDetail) {
        materialDetailNameLabel.text = data.nameEng
        supplierNameLabel.text = data.supplier.name
        supplierAddressLabel.text = data.supplier.address
        supplierContactLabel.text = data.supplier.contactName
    }
}
