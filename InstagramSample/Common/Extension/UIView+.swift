//
//  UIView+.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 09/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        
        return self.snp
    }
}
