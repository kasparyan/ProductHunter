//
//  DetailedPostCell.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailedPostCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var productNameLb: UILabel!
    @IBOutlet weak var taglineLb: UILabel!
    @IBOutlet weak var imageIv: UIImageView!
    @IBOutlet weak var descriptionLb: UILabel!
    @IBOutlet weak var upvoteIndicator: UpvoteIndicator!
    
    public func setupData(post: Post) {
        productNameLb.text = post.prodName
        taglineLb.text = post.tagline
        if let imageUrl = post.imageUrl {
            setImage(url: imageUrl)
        }
        descriptionLb.text = post.description
        upvoteIndicator.upvotes = post.voteCount ?? 0
    }
    
    private func setImage(url: String) {
        let placeholderImage = UIImage(named: "placeholder")
        if let url = URL(string: url), let placeholder = placeholderImage {
            imageIv.af_setImage(withURL: url, placeholderImage: placeholder)
        }
    }
}
