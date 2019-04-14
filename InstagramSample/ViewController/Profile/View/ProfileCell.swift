//
//  ProfileCell.swift
//  InstagramSample
//
//  Created by JHH on 11/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import AlamofireImage
import SnapKit


final class ProfileCell: UICollectionViewCell {
    private var thumbnail     : UIImageView = UIImageView()
    private var titleLabel    : UILabel     = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    var contentData : RecentData?{
        didSet{
            self.contentChanged()
        }
    }
    
    
    func setupUI(){
        self.backgroundColor = .black
        self.addSubview(thumbnail)
        self.addSubview(titleLabel)
        self.thumbnail.snp.makeConstraints{
            $0.width.equalTo(self.thumbnail.snp.height).multipliedBy(1.0/1.0)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(thumbnail.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
        }
        
    }
    
    private func contentChanged(){
        guard let contentData = self.contentData else { return }
        
        let imageURL      = contentData.images?.thumbnail?.url ?? ""
        let cacheIdentify = contentData.mediaID ?? "thumbnail"
        
        self.thumbnail.cacheImageView(urlString: imageURL, identifier: cacheIdentify)
        self.titleLabel.text = contentData.caption?.text ?? ""
    }
    
    
    func removeImageCache(){
        guard let contentData = self.contentData else { return }
        let cacheIdentify = contentData.mediaID ?? "thumbnail"
        let imageCache = AutoPurgingImageCache()
        imageCache.removeImage(withIdentifier: cacheIdentify)
    }
}
