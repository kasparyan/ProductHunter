//
//  Repository.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

final class Repository {
    static let shared = Repository()
    
    private init() {}
    
    func getPosts(success: @escaping ([Post]) -> (),
                  failure: @escaping (String?) -> ()) {
        ApiService.shared.defaultSM.request(ApiRouter.getPosts).responseCollection(withCollectionKey: "posts") { [weak self] (response: DataResponse<[Post]>) in
            if response.result.isSuccess {
                if let posts = response.result.value {
                    success(posts)
                } else {
                    debugPrint("\(String(describing: self)).performApiCalls posts are invalid")
                    failure("Invalid JSON")
                }
            } else {
                failure(response.result.error.debugDescription)
            }
        }
    }
    
    func getPost(id: Int,
                 success: @escaping (Post) -> (),
                 failure: @escaping (String?) -> ()) {
        ApiService.shared.defaultSM.request(ApiRouter.getPost(postId: id)).responseObject(withDataKey: "post") { [weak self] (response: DataResponse<Post>) in
            if response.result.isSuccess {
                if let post = response.result.value {
                    success(post)
                } else {
                    debugPrint("\(String(describing: self)).performApiCalls post is invalid")
                    failure("Invalid JSON")
                }
            } else {
                failure(response.result.error.debugDescription)
            }
        }
    }
    
    func getImageData(url: String,
                      success: @escaping (UIImage) -> (),
                      failure: @escaping (String?) -> ()) {
        Alamofire.request(url).responseImage { (response) in
            if response.result.isSuccess {
                if let image = response.result.value {
                    success(image)
                }
            } else {
                failure(response.result.error.debugDescription)
            }
        }
    }
}
