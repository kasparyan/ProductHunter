//
//  MasterViewModel.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire

final class MasterViewModel {
    
    //MARK: Data
    var posts: [Post]?
    
    func getData(success: @escaping ([Post]) -> (), failure: @escaping (String?) -> ()) {
        Repository.shared.getPosts(success: { [weak self] (posts) in
            self?.posts = posts
            success(posts)
        }) { (msg) in
            failure(msg)
        }
    }
}

