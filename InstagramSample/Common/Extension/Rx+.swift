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
    
    
    func withLatesFrom<T, U, R>(other1: Observable<T>, other2: Observable<U>, selector: @escaping (E, T, U) -> R) -> Observable<R> {
        return self.withLatestFrom(Observable<Any>.combineLatest(
            other1,
            other2
        )) { x, y in selector(x, y.0, y.1) }
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

