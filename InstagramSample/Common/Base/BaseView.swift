//
//  BaseView.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 12/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

class BaseView: UIView {
    // MARK: Properties
    weak var vc: BaseViewController!
    
    // MARK: Initialize
    required init(controlBy viewController: BaseViewController) {
        vc = viewController
        super.init(frame: UIScreen.main.bounds)
        self.setupUI()
        self.setupBinding()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        //Override
    }
    
    func setupBinding() {
        //Override
    }
    
    // MARK: Deinit
    deinit {
        
    }
}
