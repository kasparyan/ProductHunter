//
//  UpvoteIndicator.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class UpvoteIndicator: NibView {
    
    //MARK: Outlets
    @IBOutlet weak var upvotedLb: UILabel!
    
    //MARK: Data
    var upvotes: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    private func updateView() {
        upvotedLb.text = "\(upvotes)"
    }
}
