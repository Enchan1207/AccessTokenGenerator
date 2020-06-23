//
//  IconFetcher.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/22.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import Swifter

class IconFetcher{
    private var swifter: Swifter?
    private let manager = FileManager.default
    private var cachePath: String = ""
    
    init(token: AccessToken){
        swifter = Swifter(apikey: APIKey(), accesstoken: token)
        
        // fileManagerを設定し、iconディレクトリがない場合は新規生成
        cachePath = manager.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        if !manager.fileExists(atPath: cachePath + "icon"){
            do{
                try manager.createDirectory(atPath: cachePath + "icon/", withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
    }
    
    // フェッチ
    func fetch(user: userModel){
        let targetID = user.userid

        self.swifter?.showUser(.id(targetID), includeEntities: true, success: { (json) in
            // アイコンURLから数種類の画像を取得(tableView用のものと、details用のものと)
            if let iconURLString = json["profile_image_url_https"].string {
                let pattern = "https://(.+)_normal(.+)$"
                let sizeSuffixes: [String] = ["https://$1_200x200$2"]
                for suffix in sizeSuffixes {
                    guard let iconURL = URL(string: iconURLString.regexReplace(pattern: pattern, replace: suffix)) else{ continue }
                    
                    // Dataを取得して保存
                    if let iconData = try? Data(contentsOf: iconURL) {
                        let iconName = targetID
                        let iconPath = self.cachePath + "icon/" + iconName + ".png"
                        print(self.manager.createFile(atPath: iconPath, contents: iconData, attributes: nil))
                    }
                }
            }
        }, failure: { (error) in
            print(error)
        })
    }
}
