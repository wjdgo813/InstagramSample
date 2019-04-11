//
//  ProfileModel.swift
//  InstagramSample
//
//  Created by JHH on 11/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

import RxDataSources


struct SectionOfMedia {
    var header: Profile
    var items : [Item]
}


extension SectionOfMedia: AnimatableSectionModelType{
    typealias Identity = String
    typealias Item     = RecentData
    
    var identity: String{
        return header.data?.id ?? ""
    }
    
    init(original: SectionOfMedia, items: [Item]) {
        self = original
        self.items = items
    }
}


extension RecentData: IdentifiableType, Equatable{
    typealias Identity = String
    
    var identity: String{
        return mediaID ?? ""
    }
    
    static func == (lhs: RecentData, rhs: RecentData) -> Bool{
        return lhs.mediaID ?? "" == rhs.mediaID ?? ""
            && lhs.identity == rhs.identity
    }
}
