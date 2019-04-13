//
//  DetailViewController.swift
//  InstagramSample
//
//  Created by JHH on 12/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import SnapKit

class DetailViewController: BaseViewController {
    private lazy var detailView = DetailView(controlBy : self)
    var mediaData : RecentData {
        didSet{
            self.setupData()
        }
    }
    
    init(mediaData : RecentData){
        self.mediaData = mediaData
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = self.detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    private func setupData(){
        let profileImageURL  = self.mediaData.writer?.profilePicture ?? ""
        let contentImageURL  = self.mediaData.images?.standardResolution?.url ?? ""
        
        self.detailView.profileNickname.text = self.mediaData.writer?.userName ?? ""
        self.detailView.profileImageView.cacheImageView(urlString: profileImageURL, identifier: "DetailProfileImage")
        self.detailView.contentImageView.cacheImageView(urlString: contentImageURL, identifier: "DetailContentImage")
        self.detailView.contentText.text = self.mediaData.caption?.text ?? ""
    }
}
