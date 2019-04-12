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
    var profileData: Profile?{
        didSet{
            self.contentChanged()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    
    private lazy var profileImageView    : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints{
            $0.size.equalTo(100)
        }
        
        return imageView
    }()
    

    private lazy var profileStackView: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill;
        stackView.alignment = .center
        stackView.spacing = 30
        
        return stackView
    }()
    
    
    private lazy var numberStackView: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing;
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()
    
    private var followedByLabel : UILabel = UILabel()
    private var followsLabel    : UILabel = UILabel()
    private var mediaLabel      : UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        self.backgroundColor = .white
        self.setupNumberUI()
        self.setupContentUI()
    }
    
    
    private func setupNumberUI(){
        let followedTitle  = UILabel()
        let followsTitle   = UILabel()
        let mediaTitle     = UILabel()
        
        followedTitle.text = "팔로워"
        followsTitle.text  = "팔로잉"
        mediaTitle.text    = "게시물"
        
        let followedStack = self.getVerticalStack()
        followedStack.addArrangedSubview(followedTitle)
        followedStack.addArrangedSubview(self.followedByLabel)
        
        let followsStack = self.getVerticalStack()
        followsStack.addArrangedSubview(followsTitle)
        followsStack.addArrangedSubview(self.followsLabel)
        
        let mediaStack = self.getVerticalStack()
        mediaStack.addArrangedSubview(mediaTitle)
        mediaStack.addArrangedSubview(self.mediaLabel)
        
        self.numberStackView.addArrangedSubview(followedStack)
        self.numberStackView.addArrangedSubview(followsStack)
        self.numberStackView.addArrangedSubview(mediaStack)
    }
    
    
    private func setupContentUI(){
        let contentStack = self.getVerticalStack()
        self.addSubview(contentStack)
        contentStack.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        self.profileStackView.addArrangedSubview(self.profileImageView)
        self.profileStackView.addArrangedSubview(self.numberStackView)

        contentStack.addArrangedSubview(self.profileStackView)
        contentStack.addArrangedSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints{
            $0.left.equalTo(self.profileImageView.snp.left).offset(20)
        }
    }
    
    private func contentChanged(){
        guard let profile = profileData else { return }
        let profileImageURL = profile.data?.profilePicture ?? ""
        
        self.nameLabel.text = profile.data?.userName ?? ""
        self.profileImageView.cacheImageView(urlString: profileImageURL, identifier: "Profile")
        self.followedByLabel.text = "\(profile.data?.counts?.followed_by ?? 0)"
        self.followsLabel.text    = "\(profile.data?.counts?.follows ?? 0)"
        self.mediaLabel.text      = "\(profile.data?.counts?.media ?? 0)"
    }
    
    
    private func getVerticalStack()->UIStackView{
        let stackView          = UIStackView()
        stackView.axis         = .vertical
        stackView.distribution = .equalSpacing;
        stackView.alignment    = .center
        stackView.spacing      = 1
        
        return stackView
    }
}
