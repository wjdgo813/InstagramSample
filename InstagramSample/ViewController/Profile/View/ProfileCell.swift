//
//  ProfileCell.swift
//  InstagramSample
//
//  Created by JHH on 11/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import SnapKit

final class ProfileCell: UICollectionViewCell {
    private var thumbnail: UIImageView? = UIImageView()
    var contentData : RecentData?{
        didSet{
            self.contentChanged()
        }
    }
    
    func setupUI(){
        guard let thumbnail = self.thumbnail else { return }
        self.backgroundColor = .red
        self.addSubview(thumbnail)
        thumbnail.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func contentChanged(){
        guard let contentData = self.contentData else { return }
        
//        contentData.images?.thumbnail?.url
    }
}
