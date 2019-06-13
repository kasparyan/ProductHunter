//
//  UIViewController+Extensions.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func getViewControllerWithStoryboard(sbName: String , vcIdentifier: String) -> UIViewController? {
        let sb = UIStoryboard.init(name: sbName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIdentifier)
        return vc
    }
    
}
