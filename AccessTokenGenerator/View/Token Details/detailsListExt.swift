//
//  detailsListExt.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import UIKit

extension TokenDetailsViewController: UITableViewDelegate {
    
}

extension TokenDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return nil
        }
        
        return "Generated AccessToken"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 176
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoElementCell") as! userInfoElementCell
            cell.userIDLabel?.text = self.user?.userid
            cell.screenNameLabel?.text = self.user?.screenName
            cell.iconView?.image = self.user?.getIconImage() ?? UIImage(systemName: "person.crop.circle")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accessTokenElementCell") as! accessTokenElementCell
            switch indexPath.row {
            case 0:
                cell.typeLabel?.text = "token"
                cell.contentLabel?.text = self.user?.getToken()?.key
                break
            
            case 1:
                cell.typeLabel?.text = "secret"
                cell.contentLabel?.text = self.user?.getToken()?.secret
                break
                
            case 2:
                cell.typeLabel?.text = "created"
                cell.contentLabel?.text = self.user?.getFormattedDate()
                break
            default:
                break
            }
            return cell
        }
    }
    
}
