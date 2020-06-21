//
//  ViewController.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/18.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import UIKit
import Swifter
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var TokenListView: UITableView!
    
    var users: [User] = []
    let swifter: Swifter = Swifter(consumerKey: APIKey().key, consumerSecret: APIKey().secret)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listCellNib = UINib(nibName: "TokenListCell", bundle: nil)
        self.TokenListView.register(listCellNib, forCellReuseIdentifier: "TokenListCell")
        self.TokenListView.delegate = self
        self.TokenListView.dataSource = self
    }
    
    // トークン新規生成
    @IBAction func onTapGenerate(_ sender: Any) {
        swifter.authorize(
            withCallback: URL(string: "swifter-525iXmLlWodKa9BDYhzR8J3tx://")!,
            presentingFrom: self,
            success: { (token, response) in
                // ユーザ生成
                let user = User(screenName: token!.screenName!, userid: token!.userID!, token: AccessToken(key: token!.key, secret: token!.secret))
                self.users.append(user)
                
                // トークン生成完了画面を表示
                let currentSB = UIStoryboard(name: "Main", bundle: nil)
                let generatedVC = currentSB.instantiateViewController(identifier: "generatedScreen") as! GeneratedTokenViewController
                generatedVC.generatedUser = user
                self.present(generatedVC, animated: true, completion: nil)
                
                self.TokenListView.reloadData()
            },
                failure: { error in
                    print(error)
            }
        )
    }
}
