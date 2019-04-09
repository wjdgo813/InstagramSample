//
//  Notification+.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

extension Notification.Name{
    struct session{
        static let didChange:Notification.Name = Notification.Name("sessionDidChange")
    }
}
