//
//  TokenDetailsVC.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import UIKit

class TokenDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsView: UITableView!
    var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userInfoNib = UINib(nibName: "userInfoElementCell", bundle: nil)
        self.detailsView.register(userInfoNib, forCellReuseIdentifier: "userInfoElementCell")
        let accessTokenNib = UINib(nibName: "accessTokenElementCell", bundle: nil)
        self.detailsView.register(accessTokenNib, forCellReuseIdentifier: "accessTokenElementCell")
        
        self.detailsView.delegate = self
        self.detailsView.dataSource = self
        
    }
    
}
