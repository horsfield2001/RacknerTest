//
//  CatImagesViewController.swift
//  RacknerTest
//
//  Created by Christopher Horsfield on 8/12/20.
//  Copyright © 2020 Christopher Horsfield. All rights reserved.
//

import UIKit
import Alamofire

class CatImagesViewController: UICollectionViewController {
    let apiKey = "eba04eae-3ca7-43f3-b768-9db7486925a2"
    let reuseIdentifier = "CatImageCell"
    var items: [Dictionary<String, Any>] = []
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AF.request("https://api.thecatapi.com/v1/images/search",
                   parameters: ["format": "json",
                                "limit": 100,
                                "page":0,
                                "size":"thumb"],
                   headers: ["x-api-key": apiKey])
            .validate()
            .responseJSON { (response) in
                
                guard let cats = response.value else { return }
                
                self.items = cats as! [Dictionary<String, Any>]
                self.collectionView?.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CatImagesViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        // Configure the cell
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension CatImagesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
