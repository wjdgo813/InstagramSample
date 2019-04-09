//
//  APIRouter.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 09/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    //내 정보 조회
    case ownerInformation
    //내 최신 게시물 조회
    case recentMedia(maxID:String,minID:String,count:Int)
    //mediaID에 해당하는 댓글 조회
    case comments(mediaID:String)
    
    
    func asURLRequest() throws -> URLRequest {
        let url = self.url
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = self.method.rawValue
        
        if let parameter = self.parameter {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameter)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    
    private var url: URL{
        return URL(string: "https://api.instagram.com/v1")!
    }
    
    
    private var method: HTTPMethod{
        return .get
    }
    
    
    private var path: String{
        switch self {
        case .ownerInformation:
            return "/users/self/"
        case .recentMedia(_,_,_):
            return "/users/self/media/recent/"
        case .comments(let mediaID):
            return "/media/\(mediaID)/comments"
        }
    }
    
    
    private var parameter: Parameters?{
        var param : Parameters = [:]
        param["access_token"] = UserInfo.token
        
        switch self{
        case .comments(_):
            break
        case .ownerInformation:
            break
        case .recentMedia(let maxID, let minID,let count):
            param["MAX_ID"] = maxID
            param["MIN_ID"] = minID
            param["COUNT"]  = count
            break
        }
        
        return param
    }
}
