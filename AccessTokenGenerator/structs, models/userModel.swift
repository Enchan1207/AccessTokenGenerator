//
//  userModel.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/21.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import RealmSwift

class userModel: Object {
    // object properties
    @objc dynamic var screenName: String = "screenName"
    @objc dynamic var userid: String = "userid"
    @objc private dynamic var tokenString: String = "{}"
    @objc private dynamic var created: Double = Date().timeIntervalSince1970
    
    // ユーザインスタンスを生成
    required convenience init(screenName: String, userid: String, token: AccessToken){
        self.init()
        // そのまま突っ込めるプロパティはそのままにして、
        self.screenName = screenName
        self.userid = userid
        self.created = Date().timeIntervalSince1970
        
        // アクセストークンはJSONエンコードして戻す トークンで検索する需要ないからね
        let encoder = JSONEncoder()
        if let encodedTokenData = try? encoder.encode(token) {
            let encodedToken = String(data: encodedTokenData, encoding: .utf8)!
            self.tokenString = encodedToken
        }else{
            self.tokenString = ""
        }
    }
    
    // トークン取得
    func getToken() -> AccessToken?{
        guard let decodedToken = try? JSONDecoder().decode(AccessToken.self, from: self.tokenString.data(using: .utf8)!) else{ return nil}
        return decodedToken
    }
    
    // 整形済トークン文字列の取得
    func getTokenDescription() -> String? {
        guard let token = getToken() else { return nil }
        return "key:\(token.key)\nsecret:\(token.secret)"
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
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
        let iconPath = cachePath + "/icon/" + iconName
        
        guard let iconData = try? Data(contentsOf: URL(fileURLWithPath: iconPath)) else{ return nil }
        
        let icon = UIImage(data: iconData)
        return icon
    }
    
}
