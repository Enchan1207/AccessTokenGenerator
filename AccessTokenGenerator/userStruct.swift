//
//  userStruct.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    var screenName: String
    let userid: String
    let token: AccessToken
    let created: Double
    
    // ユーザインスタンスを生成
    init(screenName: String, userid: String, token: AccessToken){
        // いつもの
        self.screenName = screenName
        self.userid = userid
        self.token = token
        self.created = Date().timeIntervalSince1970
    }
    
    // 整形済の日付文字列を取得
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = Date(timeIntervalSince1970: self.created)
        return formatter.string(from: date)
    }
    
    // アイコン画像取得
    func getIconImage() -> UIImage? {
        let manager = FileManager.default
        let iconName = self.userid
        let cachePath = manager.urls(for: .cachesDirectory, in: .userDomainMask)[0].absoluteString
        let iconPath = cachePath + "/icon/" + iconName
        
        guard let iconData = try? Data(contentsOf: URL(string: iconPath)!) else{ return nil }
        
        let icon = UIImage(data: iconData)
        return icon
    }
}
