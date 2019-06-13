//
//  Comment.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

struct Comment: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    //MARK: JSON keys
    static let ID_KEY = "id"
    static let BODY_KEY = "body"
    static let CREATED_AT_KEY = "created_at"
    static let USER_KEY = "user"
    static let USER_NAME_KEY = "name"
    
    //MARK: Properties
    let id: Int?
    var body: String?
    var date: String?
    var userName: String?
    
    
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
        body = json[Comment.BODY_KEY] as? String
        date = json[Comment.CREATED_AT_KEY] as? String
        if let user = json[Comment.USER_KEY] as? [String : Any] {
            userName = user[Comment.USER_NAME_KEY] as? String
        }
    }
}
