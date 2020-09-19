//
//  BottomOverlayView.swift
//  MVP
//
//  Created by satrio.wicaksono on 19/09/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import Foundation
import UIKit

class BottomOverlayView: UIView {
    
    //MARK: IBOutlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: Properties
    private let className = String(describing: BottomOverlayView.self)
    
    //MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, title: String, content: String) {
        super.init(frame: frame)
        Bundle(for: BottomOverlayView.self).loadNibNamed(className, owner: self, options: nil)
        self.addSubview(backgroundView)
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        titleLabel.text = title
        contentLabel.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    @IBAction func okButtonTapped() {
        self.removeFromSuperview()
    }
}
