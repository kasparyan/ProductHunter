//
//  DetailViewModel.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

final class DetailViewModel {
    
    //MARK: Data
    var post: Post?
    
    func getData(id: Int, success: @escaping (Post) -> (), failure: @escaping (String?) -> ()) {
        Repository.shared.getPost(id: id, success: { [weak self] (post) in
            self?.post = post
            success(post)
        }) { (msg) in
            failure(msg)
        }
    }
}
