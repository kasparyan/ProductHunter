//
//  BaseViewController.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: Indicator
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
    
    //MARK: State properties
    private var viewIsAppierd: Bool = false {
        didSet {
            if self.viewIsAppierd && isLoadingInQueue {
                self.view.bringSubviewToFront(indicator)
                indicator.startAnimating()
                isLoadingInQueue = false
            }
        }
    }
    var isLoadingInQueue: Bool = false
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupIndicator()
        viewIsAppierd = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewIsAppierd = false
    }
    
    private func setupIndicator() {
        indicator.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        indicator.hidesWhenStopped = true
        let frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        indicator.frame = frame
        self.view.addSubview(indicator)
        indicator.stopAnimating()
    }
    
    func showErrorDialog(withMsg msg: String? = nil) {
        let alert = UIAlertController(title: title ?? "Error", message: msg ?? "Unknown error!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        if viewIsAppierd {
            self.view.bringSubviewToFront(indicator)
            indicator.startAnimating()
        } else {
            isLoadingInQueue = true
        }
        
    }
    
    func hideLoadingIndicator() {
        indicator.stopAnimating()
        if isLoadingInQueue {
            isLoadingInQueue = false
        }
    }
}
