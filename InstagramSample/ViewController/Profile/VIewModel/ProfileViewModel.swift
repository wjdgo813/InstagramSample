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
    let profileTrigger  = PublishSubject<Void>()
    let moreLoadTrigger = PublishSubject<Void>()
    
    //output
    var media           : Driver<[SectionOfMedia]>?
    let apiError        = PublishSubject<String>()
    let resultMedia     = BehaviorSubject<RecentMedia>(value: RecentMedia())
    
    let disposeBag   = DisposeBag()
    
    init() {
        self.setup()
    }
    
    
    private func setup(){
        let resultProfile = PublishSubject<Profile>()
        self.profileTrigger.flatMapLatest{ [weak self] _ in
                self?.fetchUserInfo() ?? Observable.never()
            }.map{
                return try JSONDecoder().decode(Profile.self, from: $0)
            }.bind(to: resultProfile).disposed(by: self.disposeBag)
        
        
        resultProfile.flatMapLatest{ [weak self] _ in
            self?.fetchRecentMedia() ?? Observable.never()
            }.map{
                return try JSONDecoder().decode(RecentMedia.self, from: $0)
            }.bind(to: self.resultMedia)
            .disposed(by: self.disposeBag)
        
        
        Observable.combineLatest(self.moreLoadTrigger,
                                 self.resultMedia) {($0, $1)}
            .filter{ $0.1.pagination?.nextURL ?? "" != "" }
            .flatMapFirst{ [weak self] result in
                self?.fetchLoadMore(nextURL: result.1.pagination?.nextURL ?? "") ?? Observable.never()
            }
            .map{
                let data = try JSONDecoder().decode(RecentMedia.self, from: $0)
                return try self.resultMedia.value().moreLoadData(newData: data)
            }.bind(to: self.resultMedia)
            .disposed(by: self.disposeBag)
        
        
        
        self.media = Observable
            .combineLatest(resultProfile,self.resultMedia) {($0, $1)}
            .filter{ $1.data != nil }
            .map{ [SectionOfMedia(header: $0, items: $1.data!)] }
            .asDriverOnErrorJustComplete()
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
    
    
    private func fetchLoadMore(nextURL: String)->Observable<Data>{
        return APIClient.rxJSONAPIObservable(url: URLRequest(url:URL(string: nextURL)!))
            .do(onError: { [weak self] _ in
                guard let self = self else { return }
                self.apiError.onNext("")
            }).suppressError()
    }
}


