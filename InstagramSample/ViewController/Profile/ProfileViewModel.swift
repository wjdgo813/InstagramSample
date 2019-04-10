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


final class ProfileViewModel: BaseViewModelType {
    
    let disposeBag   = DisposeBag()
    
    init() {
        self.setup()
    }
    
    private func setup(){
        
    }
    
    func transform(input: Input) -> Output {
        let apiError = PublishSubject<String>()
        let profilePost = input
            .trigger
            .flatMapLatest{ _ in
            APIClient.fetchUserInfo()
                .do(onError: { _ in
                    apiError.onNext("")
                }).suppressError()
                .asDriverOnErrorJustComplete()
        }
        
        profilePost.asDriver().drive(onNext: { _ in
            
        }).disposed(by: self.disposeBag)
        
        return Output(error: apiError)
    }
}


extension ProfileViewModel{
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let error: PublishSubject<String>
    }
}
