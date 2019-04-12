//
//  APIClient.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

final class APIClient{
    static func rxJSONAPIObservable(url : URLRequestConvertible)->Observable<Data>{
        return Observable.create{ emit in
            Alamofire.request(url).responseJSON(completionHandler: { response in
                print("result : \(response.value ?? "")")
                switch response.result{
                case .success(_):
                    if let data = response.data {
                        emit.onNext(data)
                    }
                    emit.onCompleted()
                case .failure(let error):
                    emit.onError(error)
                }
            })
            return Disposables.create()
        }
    }
}

extension APIClient{
    static func fetchUserInfo()->Observable<Data>{
        return rxJSONAPIObservable(url: APIRouter.ownerInformation)
    }
    
    static func fetchRecentMedia(maxID: String?, minID: String?)->Observable<Data>{
        return rxJSONAPIObservable(url: APIRouter.recentMedia(maxID: maxID ?? "", minID: minID ?? "", count: 20))
    }
}
