//
//  UIScrollView+.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 14/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

extension UIScrollView{
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        let isBottom = self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
        return self.contentOffset.y > 0 ? isBottom : false
    }
}
