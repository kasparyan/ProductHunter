//
//  PagerCell.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import AlamofireImage

class PagerCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var productNameLb: UILabel!
    @IBOutlet weak var taglineLb: UILabel!
    @IBOutlet weak var imageIv: UIImageView!
    @IBOutlet weak var upvotesIndicator: UpvoteIndicator!
    @IBOutlet weak var commentIndicator: CommentIndicator!
    
    public func setupData(post: Post) {
        productNameLb.text = post.prodName
        taglineLb.text = post.tagline
        upvotesIndicator.upvotes = post.voteCount ?? 0
        commentIndicator.comments = post.commentCount ?? 0
        if let imageUrl = post.imageUrl {
            setImage(url: imageUrl)
        }
    }
    
    private func setImage(url: String) {
        let placeholderImage = UIImage(named: "placeholder")
        if let url = URL(string: url), let placehodler = placeholderImage {
            imageIv.af_setImage(withURL: url, placeholderImage: placehodler)
        }
    }
}
