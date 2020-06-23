//
//  TokenDetailsVC.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import Swifter
import Accounts
import UIKit

class TokenDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsView: UITableView!
    var user: userModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userInfoNib = UINib(nibName: "userInfoElementCell", bundle: nil)
        self.detailsView.register(userInfoNib, forCellReuseIdentifier: "userInfoElementCell")
        let accessTokenNib = UINib(nibName: "accessTokenElementCell", bundle: nil)
        self.detailsView.register(accessTokenNib, forCellReuseIdentifier: "accessTokenElementCell")
        
        self.detailsView.delegate = self
        self.detailsView.dataSource = self
    }
    
    @IBAction func onTapDelete(_ sender: Any) {        
        // actionsheetを作る
        let removeAlert = UIAlertController(
            title: "Delete this token",
            message: "Do you delete this token?\ndeleted token can't restore.",
            preferredStyle: .actionSheet
        );
        
        // ボタン追加
        let acceptButton = UIAlertAction(
            title: "yes, I delete this token.",style: .destructive,
            handler: {(alert) in
                guard let targetUser = self.user else { return }
                UserManager().remove(user: targetUser)
                self.navigationController?.popViewController(animated: true)
        }
        );
        let cancelButton = UIAlertAction(title: "cancel",style: .cancel,handler: nil);
        removeAlert.addAction(acceptButton);
        removeAlert.addAction(cancelButton);
        
        present(removeAlert, animated: true, completion: nil)
    }
    
    @IBAction func onTapShare(_ sender: Any) {
        // 共有する項目
        guard let shareText = self.user?.getTokenDescription() else{ return }
        let activityItems = [shareText]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func onTapReflesh(_ sender: Any) {
        // 多方面からアクセスし直す
        if let token = self.user?.getToken(){
            let swifter = Swifter(apikey: APIKey(), accesstoken: token)
            swifter.showUser(.id(self.user!.userid), includeEntities: true, success: { (json) in
                print(json)
            }) { (error) in
                print(error)
            }
        }
    }
    
}
