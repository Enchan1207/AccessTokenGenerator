//
//  TokenListViewExt.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsSB = UIStoryboard(name: "TokenDetails", bundle: nil)
        let initialVC = detailsSB.instantiateInitialViewController() as! TokenDetailsViewController
        initialVC.user = self.users[indexPath.row]
        initialVC.modalPresentationStyle = .fullScreen
        navigationController?.show(initialVC, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.manager.remove(user: self.users[indexPath.row])
            self.users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TokenListCell") as! TokenListCell
        cell.screenNameLabel?.text = self.users[indexPath.row].screenName
        cell.modifiedLabel?.text = self.users[indexPath.row].getFormattedDate()
        
        return cell
    }
    
}
