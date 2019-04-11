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
    var media           : Driver<SectionOfMedia>?
    let apiError = PublishSubject<String>()
    
    let disposeBag   = DisposeBag()
    
    init() {
        self.setup()
    }
    
    
    private func setup(){
        let resultProfile = PublishSubject<Profile>()
        self.profileTrigger.flatMapLatest{
                self.fetchUserInfo()
            }.map{
                return try JSONDecoder().decode(Profile.self, from: $0)
            }.bind(to: resultProfile).disposed(by: self.disposeBag)
        
        
        let resultMedia = resultProfile.flatMapLatest{ _ in
            self.fetchRecentMedia()
            }.map{
                return try JSONDecoder().decode(RecentMedia.self, from: $0)
        }
        
        
        self.media = Observable.combineLatest(resultProfile,resultMedia){ ($0, $1) }.map{
            return SectionOfMedia(header: $0, items: $1.data!)
        }.asDriverOnErrorJustComplete()
    }
}

//fetch API
extension ProfileViewModel{
    
    private func fetchUserInfo()->Observable<Data>{
        return APIClient.fetchUserInfo().do(onError: { [weak self] _ in
            guard let self = self else { return }
            self.apiError.onNext("")
        }).suppressError()
    }
    
    private func fetchRecentMedia(maxID: String? = nil, minID: String? = nil)->Observable<Data>{
        return APIClient.fetchRecentMedia(maxID: maxID,minID: minID).do( onError:{ [weak self] _ in
            guard let self = self else { return }
            self.apiError.onNext("")
        }).suppressError()
    }
}


