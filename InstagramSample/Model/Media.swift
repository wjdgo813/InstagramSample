//
//  Media.swift
//  InstagramSample
//
//  Created by JHH on 11/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct RecentMedia: Codable {
    var pagination : RecentPagination?
    var data       : [RecentData]?
}

struct RecentPagination: Codable{
    var nextURL   : String?
    var nextMaxID : String?
    
    enum CodingKeys: String, CodingKey {
        case nextURL   = "next_url"
        case nextMaxID = "next_max_id"
    }
}


struct RecentData: Codable {
    var mediaID : String?
    var writer  : WriterUser?
    var images  : Images?
    var caption : Caption?
    var type    : String?
    var carouselMedia : [Images]?
    
    enum CodingKeys: String, CodingKey {
        case mediaID = "id"
        case writer  = "user"
        case carouselMedia = "carousel_media"
        case images, caption, type
    }
    
    init(from decoder: Decoder) throws {
        let values         = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaID       = try? values.decode(String.self, forKey: .mediaID)
        self.writer        = try? values.decode(WriterUser.self, forKey: .writer)
        self.images        = try? values.decode(Images.self, forKey: .images)
        self.caption       = try? values.decode(Caption.self, forKey: .caption)
        self.type          = try? values.decode(String.self, forKey: .type)
        self.carouselMedia = try? values.decode([Images].self, forKey: .carouselMedia)
    }
}



struct WriterUser: Codable {
    var fullName       : String?
    var profilePicture : String?
    var userName       : String?
    
    enum CodingKeys: String, CodingKey {
        case fullName       = "full_name"
        case profilePicture = "profile_picture"
        case userName       = "username"
    }
}


struct Images: Codable{
    var thumbnail          : Image?
    var standardResolution : Image?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail
        case standardResolution = "standard_resolution"
    }
}


struct Image: Codable{
    var width  : Float?
    var height : Float?
    var url    : String?
}


struct Caption: Codable {
    var id   : String?
    var text : String?
}
