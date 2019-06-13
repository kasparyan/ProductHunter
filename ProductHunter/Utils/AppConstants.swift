//
//  AppConstants.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

final class AppConstants {
    //MARK: Network related keys
    static let BASE_URL_STRING = "https://api.producthunt.com/v1"
    static let BASIC_AUTH_KEY = "Authorization"
    
    //MARK: Media Types
    static let MEDIATYPE_IMAGE = "image"
    
    //MARK: hardcoded tokens
    static let BEARER_TOKEN = "0a13f95b6513faf93cd8f74c8cddb1dd3b926d1bd227e8f6990de62e37d3e12a"
    
    //MARK: Cell identifiers
    static let PAGER_CELL = "pager_cell"
    static let DETAILED_CELL = "detailed_cell"
    static let COMMENT_CELL = "comment_cell"
    
    //MARK: MimeTypes
    static let GIF_MIMETYPE = "image/gif"
}
