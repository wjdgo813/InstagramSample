//
//  BaseViewModelType.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

protocol BaseViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
