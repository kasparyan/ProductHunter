//
//  ApiRouter.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getPosts
    case getPost(postId: Int)
    
    func asURLRequest() throws -> URLRequest {
        let url = try AppConstants.BASE_URL_STRING.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getPosts:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getPost:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        return urlRequest
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        case .getPost:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .getPost(let id):
            return "/posts/\(id)"
        }
    }
}
