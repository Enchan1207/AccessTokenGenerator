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
    
    var users: [userModel] = [userModel]()
    let swifter: Swifter = Swifter(apikey: APIKey())
    let manager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザリスト設定
        let listCellNib = UINib(nibName: "TokenListCell", bundle: nil)
        TokenListView.register(listCellNib, forCellReuseIdentifier: "TokenListCell")
        TokenListView.delegate = self
        TokenListView.dataSource = self
        
        let documentDirPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        print(documentDirPath)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 別のVCで変化してる可能性があるので
        if let storedList = manager.getUserList(){
            self.users = storedList
            TokenListView.reloadData()
        }
    }
    
    // トークン新規生成
    @IBAction func onTapGenerate(_ sender: Any) {
        swifter.authorize(
            withCallback: URL(string: "swifter-525iXmLlWodKa9BDYhzR8J3tx://")!,
            presentingFrom: self,
            success: { (token, response) in
                // ユーザ生成
                let user = userModel(screenName: token!.screenName!, userid: token!.userID!, token: AccessToken(key: token!.key, secret: token!.secret))
                self.manager.add(user: user)
                self.users.append(user)
                
                // バックグラウンドでアイコン画像を取得
                DispatchQueue.main.async {
                    if let token = user.getToken(){
                        IconFetcher(token: token).fetch(user: user)
                    }
                }
                
                // トークン生成完了画面を表示
                let currentSB = UIStoryboard(name: "Main", bundle: nil)
                let generatedVC = currentSB.instantiateViewController(identifier: "generatedScreen") as! GeneratedTokenViewController
                generatedVC.generatedUser = user
                self.present(generatedVC, animated: true, completion: {
                    self.TokenListView.reloadData()
                })
        },
            failure: { error in
                print("Authorize failed")
                let uiac = UIAlertController(title: "Authorize has failed", message: "please try again", preferredStyle: .alert)
                let defaultAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                uiac.addAction(defaultAction)
                self.present(uiac, animated: true, completion: nil)
        }
        )
    }
}
