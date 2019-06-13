//
//  DefaultAdapter.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire

class DefaultAdapter: RequestAdapter {
    
    private let bearerToken: String?
    
    init(bearerToken: String?) {
        self.bearerToken = bearerToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(AppConstants.BASE_URL_STRING) {
            if let bToken = bearerToken {
                urlRequest.setValue("Bearer \(bToken)",
                    forHTTPHeaderField: AppConstants.BASIC_AUTH_KEY)
            }
        }
        return urlRequest
    }
}
