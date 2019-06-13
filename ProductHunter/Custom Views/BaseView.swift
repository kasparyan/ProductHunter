//
//  BaseView.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

@IBDesignable
class BaseView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupCorderRadius(with: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupBorderWidth(with: borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
        didSet {
            setupBorderColor(with: borderColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setupCorderRadius(with radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    private func setupBorderWidth(with width: CGFloat) {
        layer.borderWidth = width
    }
    
    private func setupBorderColor(with color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    private func setup() {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
