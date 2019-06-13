//
//  Post.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

struct Post: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    //MARK: JSON keys
    static let ID_KEY = "id"
    static let PROD_NAME_KEY = "name"
    static let TAGLINE_KEY = "tagline"
    static let COMMENT_COUNT_KEY = "comments_count"
    static let VOTE_COUNT_KEY = "votes_count"
    static let THUMBNAIL_KEY = "thumbnail"
    static let IMAGE_URL_KEY = "image_url"
    static let MEDIA_TYPE_KEY = "media_type"
    static let DESCRIPTION_KEY = "description"
    static let COMMENTS_KEY = "comments"
    
    //MARK: Properties
    let id: Int?
    var prodName: String?
    var tagline: String?
    var commentCount: Int?
    var voteCount: Int?
    var imageUrl: String?
    var description: String?
    var comments: [Comment]?
    
    init?(response: HTTPURLResponse, representation: Any, withDataKey dKey: String?) {
        if let json = representation as? [String : Any] {
            if let key = dKey,
                let keyJson = json[key] as? [String : Any] {
                self.init(json: keyJson)
            } else {
                self.init(json: json)
            }
        } else {
            return nil
        }
    }
    
    init(json: [String : Any]) {
        id = json[Post.ID_KEY] as? Int
        prodName = json[Post.PROD_NAME_KEY] as? String
        tagline = json[Post.TAGLINE_KEY] as? String
        commentCount = json[Post.COMMENT_COUNT_KEY] as? Int
        voteCount = json[Post.VOTE_COUNT_KEY] as? Int
        if let thumbnail = json[Post.THUMBNAIL_KEY] as? [String : Any],
            let mediaType = thumbnail[Post.MEDIA_TYPE_KEY] as? String,
            mediaType == AppConstants.MEDIATYPE_IMAGE,
            let imageUrl = thumbnail[Post.IMAGE_URL_KEY] as? String
        {
            self.imageUrl = imageUrl
        }
        description = json[Post.DESCRIPTION_KEY] as? String
        if let comments = json[Post.COMMENTS_KEY] as? [[String : Any]] {
            var commentsArray = [Comment]()
            comments.forEach { (comment) in
                commentsArray.append(Comment(json: comment))
            }
            self.comments = commentsArray
        }
    }
    
}
