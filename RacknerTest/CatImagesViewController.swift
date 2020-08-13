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
    private let reuseIdentifier = "CatImageCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //https://api.thecatapi.com/v1/images/search?format=json&limit=100&page=0&size=thumb
        AF.request("https://api.thecatapi.com/v1/images/search",
                   parameters: ["format": "json",
                                "limit": 100,
                                "page":0,
                                "size":"thumb"],
                   headers: ["x-api-key": apiKey])
            .responseJSON { (data) in
                print(data)
        }
    }
}
