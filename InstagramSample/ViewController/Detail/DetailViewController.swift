//
//  DetailViewController.swift
//  InstagramSample
//
//  Created by JHH on 12/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import SnapKit

class DetailViewController: UIViewController {
    private var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.label)
        self.label.text = "하윙"
        
        self.label.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
