//
//  UIImageView+.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 12/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView{
    func cacheImageView(urlString: String, identifier: String){
        if let url = URL(string: urlString) {
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
                else { return }
            
            let imageCache = AutoPurgingImageCache()
            imageCache.add(image, withIdentifier: identifier)
            self.image = imageCache.image(withIdentifier: identifier)
        }
        
    }
}
