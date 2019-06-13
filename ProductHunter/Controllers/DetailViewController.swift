//
//  DetailViewController.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var postTv: UITableView!
    
    //MARK: Data
    var postId: Int?
    
    //View Model
    private let model = DetailViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        performApiCalls()
    }
    
    private func initTableView() {
        postTv.dataSource = self
        postTv.register(UINib(nibName: "DetailedPostCell", bundle: nil), forCellReuseIdentifier: AppConstants.DETAILED_CELL)
        postTv.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: AppConstants.COMMENT_CELL)
    }
    
    private func performApiCalls() {
        if let id = postId {
            showLoadingIndicator()
            model.getData(id: id, success: { [weak self] (post) in
                self?.hideLoadingIndicator()
                self?.postTv.isHidden = false
                self?.postTv.reloadData()
            }) { [weak self] (msg) in
                self?.hideLoadingIndicator()
                self?.showErrorDialog(withMsg: msg)
            }
        } else {
            showErrorDialog(withMsg: "No postId.")
        }
    }
}

//MARK: UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && model.post != nil {
            return 1
        } else {
            return model.post?.comments?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.DETAILED_CELL, for: indexPath)
            if let detCell = cell as? DetailedPostCell, let post = self.model.post {
                detCell.setupData(post: post)
                return detCell
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.COMMENT_CELL, for: indexPath)
            if let commentCell = cell as? CommentCell, let comment = model.post?.comments?[indexPath.row] {
                commentCell.setupData(comment: comment)
                return commentCell
            }
            return cell
        }
    }
}
