//
//  CanShowAlert.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 14/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

protocol CanShowAlert where Self:BaseViewController{
    func showAlert(title : String?,
                   message:String?,
                   confirmButtonTitle:String?,
                   completion:(()->())?)
}


extension CanShowAlert{
    func showAlert(title : String?,
                   message:String?,
                   confirmButtonTitle:String? = nil,
                   completion:(()->())? = nil){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: confirmButtonTitle ?? "확인", style: .default, handler: { (result) in
            if (completion != nil) {
                completion!()
            }
        })
        
        alertController.addAction(confirmAlert)
        self.present(alertController, animated: true, completion: nil)
    }
}

