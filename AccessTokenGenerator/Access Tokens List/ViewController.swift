//
//  ViewController.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/18.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TokenListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listCellNib = UINib(nibName: "TokenListCell", bundle: nil)
        self.TokenListView.register(listCellNib, forCellReuseIdentifier: "TokenListCell")
        self.TokenListView.delegate = self
        self.TokenListView.dataSource = self
    }
    
    // トークン新規生成
    @IBAction func onTapGenerate(_ sender: Any) {
        
    }
    
}

