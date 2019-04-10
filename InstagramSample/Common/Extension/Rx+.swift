//
//  Rx+.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

extension ObservableType {
    func suppressError() -> Observable<E> {
        return retryWhen { _ in return Observable<E>.empty()  }
    }
}

extension ObservableType{
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
}


extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}


extension Reactive where Base: UIViewController{
    var viewWillAppear: ControlEvent<Void>{
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
        return ControlEvent(events: source)
    }
}

