//
//  CommentCell.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var userNameLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    
    public func setupData(comment: Comment) {
        userNameLb.text = comment.userName
        dateLb.text = comment.date?.dateFromString().stringFromDate()
        bodyLb.text = comment.body
    }
    
}

