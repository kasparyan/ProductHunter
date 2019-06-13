//
//  MasterViewController.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MasterViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var postsCV: UICollectionView! {
        didSet {
            if let postsCV = self.postsCV,
                UIDevice.current.userInterfaceIdiom == .pad
            {
                if let layout = postsCV.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .vertical
                }
            }
        }
    }
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    //MARK: View Model
    private let model = MasterViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSplitViewDelegate()
        initCollectionView()
        performApiCalls()
    }
    
    private func setSplitViewDelegate() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            splitViewController?.delegate = self
        }
    }
    
    private func initCollectionView() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            postsCV.isPagingEnabled = false
            let newConstraint = self.bottomViewConstraint.constraintWithMultiplier(0.0)
            self.view!.removeConstraint(self.bottomViewConstraint)
            self.view!.addConstraint(newConstraint)
            self.view!.layoutIfNeeded()
        }
        postsCV.delegate = self
        postsCV.dataSource = self
        postsCV.register(UINib(nibName: "PagerCell", bundle: nil), forCellWithReuseIdentifier: AppConstants.PAGER_CELL)
    }
    
    private func performApiCalls() {
        showLoadingIndicator()
        model.getData(success: { [weak self] (posts) in
            self?.hideLoadingIndicator()
            self?.postsCV.reloadData()
        }) { [weak self] (msg) in
            self?.hideLoadingIndicator()
            self?.showErrorDialog(withMsg: msg)
        }
    }
}

//MARK: UICollectionViewDataSource
extension MasterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.PAGER_CELL, for: indexPath)
        if let pagerCell = cell as? PagerCell, let posts = self.model.posts {
            pagerCell.setupData(post: posts[indexPath.row])
            return pagerCell
        }
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension MasterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let posts = self.model.posts {
            let postID = posts[indexPath.row].id
            if let detailVC = getViewControllerWithStoryboard(sbName: "Main", vcIdentifier: "DetailViewContrillerID") as? DetailViewController, let id = postID
            {
                detailVC.postId = id
                self.splitViewController?.showDetailViewController(detailVC, sender: nil)
            }
        }
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension MasterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height / 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 20.0
        } else {
            return 0.0
        }
    }
}

//MARK: UISplitViewControllerDelegate
extension MasterViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
