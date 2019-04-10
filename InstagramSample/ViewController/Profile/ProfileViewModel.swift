//
//  ProfileViewModel.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift


final class ProfileViewModel {
    //input
    let profileTrigger = PublishSubject<Void>()
    
    //output
    var profileUserInfo : Driver<Profile>?
    
    let apiError = PublishSubject<String>()
    
    
    let disposeBag   = DisposeBag()
    
    init() {
        self.setup()
    }
    
    private func setup(){
        self.profileUserInfo = self.profileTrigger.flatMapLatest{
                APIClient.fetchUserInfo().do(onError: { [weak self] _ in
                        guard let self = self else { return }
                        self.apiError.onNext("")
                    }).suppressError()
            }.map{
                return try JSONDecoder().decode(Profile.self, from: $0)
            }.asDriverOnErrorJustComplete()
        
        
    }
}


