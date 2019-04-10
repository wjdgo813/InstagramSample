//
//  ViewController.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 09/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class ProfileViewController: BaseViewController {

    @IBOutlet private weak var profileCollectionView: UICollectionView!
    private let viewModel = ProfileViewModel()
    private var disposeBag: DisposeBag{
        return viewModel.disposeBag
    }
    
    override func setupUI() {
        
    }
    
    override func setupBind() {
        self.bindInput()
        self.bindOutput()
    }
    
    
    private func bindInput(){
        self.rx.viewWillAppear.debug("viewWillAppear").bind(to: self.viewModel.profileTrigger)
            .disposed(by:self.disposeBag)
    }
    
    
    private func bindOutput(){
        self.viewModel.profileUserInfo?.debug("profileUserInfo").drive(onNext: { profile in
            print("name : \(profile.data?.fullName ?? "jhh")")
        }).disposed(by: self.disposeBag)
    }
}

extension ProfileViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


