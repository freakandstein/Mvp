//
//  UILoadingView.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class UILoadingView: UIView {
    
    //MARK: Properties
    private var indicatorView: UIActivityIndicatorView?
    
    //MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView?.color = .systemBlue
        setComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    private func setComponent() {
        if let indicatorView = indicatorView {
            indicatorView.startAnimating()
            self.addSubview(indicatorView)
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                indicatorView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.12),
                indicatorView.heightAnchor.constraint(equalTo: indicatorView.widthAnchor),
                indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
    }
}
