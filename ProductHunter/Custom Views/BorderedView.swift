//
//  BorderedView.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BorderedView: UIView {
    
    @IBInspectable var borderColor: UIColor = .white {
        didSet{
            updateColors()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            setCornerRadius(at: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet{
            addBorder(withWidth: borderWidth)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        addBorder(withWidth: borderWidth)
    }
    
    private func setCornerRadius(at radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius(at: cornerRadius)
        updateColors()
    }
    
    private func addBorder(withWidth width: CGFloat) {
        layer.borderWidth = width/UIScreen.main.scale
        setCornerRadius(at: cornerRadius)
        layer.masksToBounds = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    func updateColors() {
        layer.borderColor = borderColor.cgColor
    }
    
}
