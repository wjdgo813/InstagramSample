//
//  ProfileHeaderView.swift
//  InstagramSample
//
//  Created by JHH on 11/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import SnapKit

let profileHeaderIdentifier = "profileHeaderIdentifier"
final class ProfileHeaderView: UICollectionReusableView {
    
    var nameLabel : UILabel? = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        self.backgroundColor = .white
        guard let nameLabel = self.nameLabel else { return }
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
