//
//  ProfileModel.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 10/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var data : ProfileData?
    var meta : ProfileCode?
}


struct ProfileCode : Codable {
    var code : Int
}


struct ProfileData: Codable {
    var bio            : String?
    var fullName       : String?
    var id	           : String?
    var profilePicture : String?
    var userName       : String?
    
    enum CodingKeys: String,CodingKey {
        case bio
        case id
        case fullName       = "full_name"
        case profilePicture = "profile_picture"
        case userName       = "username"
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        self.bio        = try values.decode(String.self, forKey: .bio)
        self.id         = try values.decode(String.self, forKey: .id)
        self.fullName   = try values.decode(String.self, forKey: .fullName)
        self.profilePicture = try values.decode(String.self, forKey: .profilePicture)
        self.userName   = try values.decode(String.self, forKey: .userName)
    }
}
