//
//  CommentIndicator.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CommentIndicator: NibView {
    
    //MARK: Outlets
    @IBOutlet weak var commentsLb: UILabel!
    
    //MARK: Data
    var comments: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    private func updateView() {
        commentsLb.text = "\(comments)"
    }
    
}
