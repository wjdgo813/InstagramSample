//
//  DetailView.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 12/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

protocol DetailContent {
    var profileImageView : UIImageView { get }
    var profileNickname  : UILabel     { get }
    var contentImageView : UIImageView { get }
    var contentText      : UILabel     { get }
    var replyButton      : UIButton    { get }
}


final class DetailView: BaseView, DetailContent{
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints{
            $0.size.equalTo(50)
        }
        
        return imageView
    }()
    
    
    lazy var profileNickname: UILabel = {
        let label   = UILabel()
        label.font  = .boldSystemFont(ofSize: 11)
        label.numberOfLines = 1
        return label
    }()
    
    
    lazy var contentImageView: UIImageView = {
       let imageView          = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    lazy var contentText: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize:14)
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var replyButton: UIButton = {
        let button = UIButton()
        button.setTitle("댓글 보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    
    private lazy var profileStackView: UIStackView = {
        let profileStackView  = UIStackView()
        profileStackView.axis = .horizontal
        profileStackView.distribution = .equalSpacing;
        profileStackView.alignment = .leading
        profileStackView.spacing = 5
        
        return profileStackView
    }()
    
    
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis         = .vertical
        contentStackView.distribution = .equalSpacing;
        contentStackView.alignment    = .leading
        contentStackView.spacing      = 10
        return contentStackView
    }()
    
    
    private var controller : DetailViewController? {
        guard let vc = self.vc as? DetailViewController else {return nil}
        return vc
    }
    
    
    override func setupUI(){
        self.backgroundColor = .white
        self.setupContentUI()
        self.setupProfileUI()
        self.layoutIfNeeded()
    }
    
}


extension DetailView{
    private func setupProfileUI(){
        self.profileStackView.addArrangedSubview(self.profileImageView)
        self.profileStackView.addArrangedSubview(self.profileNickname)
        
        self.profileNickname.snp.makeConstraints{
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupContentUI(){
        let scrollView = UIScrollView()
        let contentView = UIView()

        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(self.safeArea.top)
            $0.left.equalTo(self.safeArea.left)
            $0.right.equalTo(self.safeArea.right)
            $0.bottom.equalTo(self.safeArea.bottom)
        }
        
        contentView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.right.equalTo(self.safeArea.right)
            $0.left.equalTo(self.safeArea.left)
            $0.bottom.equalToSuperview()
        }
        
        contentView.addSubview(self.contentStackView)
        self.contentStackView.addArrangedSubview(self.profileStackView)
        self.contentStackView.addArrangedSubview(self.contentImageView)
        self.contentStackView.addArrangedSubview(self.contentText)
        self.contentStackView.addArrangedSubview(self.replyButton)
        self.contentStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(5)
        }
        
        
        self.contentImageView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(self.contentImageView.snp.height).multipliedBy(1.0/1.0)
        }
        
        
        self.contentText.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        
        self.replyButton.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
}
