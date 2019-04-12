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
    private var thumbnail     : UIImageView? = UIImageView()
    private var titleLabel    : UILabel?     = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    var contentData : RecentData?{
        didSet{
            self.contentChanged()
        }
    }
    
    
    func setupUI(){
        guard let thumbnail = self.thumbnail,
              let titleLabel = self.titleLabel
        else { return }
        
        self.backgroundColor = .red
        self.addSubview(thumbnail)
        self.addSubview(titleLabel)
        thumbnail.snp.makeConstraints{
            $0.size.equalTo(self.frame.width)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(thumbnail.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
        }
        
    }
    
    private func contentChanged(){
        guard let contentData = self.contentData else { return }
        
        
        let imageURL = URL(string: contentData.images?.thumbnail?.url ?? "")
        if let url = imageURL {
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else { return }
            
            let imageCache = AutoPurgingImageCache()

            imageCache.add(image, withIdentifier: "thumbnail")
            self.thumbnail?.image = imageCache.image(withIdentifier: "thumbnail")
        }
        
        self.titleLabel?.text = contentData.caption?.text ?? ""
    }
}
