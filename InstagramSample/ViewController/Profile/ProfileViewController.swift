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
        let viewWillApear = self.rx.viewWillAppear.asDriver()
        let input = ProfileViewModel.Input(trigger: viewWillApear)
        
        let output = viewModel.transform(input: input)
        
        
    }
}

extension ProfileViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


