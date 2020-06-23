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
        cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
        if !manager.fileExists(atPath: cachePath + "/icon/"){
            do{
                try manager.createDirectory(at: URL(fileURLWithPath: cachePath + "/icon/"), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
    }
    
    // フェッチ
    func fetch(user: userModel){
        let targetID = user.userid
        print("フェッ↑チ↓")
        
        self.swifter!.showUser(.id(targetID), includeEntities: true, success: { (json) in
            print(json)
            // アイコンURLから数種類の画像を取得(tableView用のものと、details用のものと)
            if let iconURLString = json["profile_image_url_https"].string {
                print("Vaild icon URL")
                let pattern = "https://(.+)_normal(.+)$"
                let sizeSuffixes: [String] = ["https://$1_200x200$2"]
                for suffix in sizeSuffixes {
                    print("get icon image data...")
                    guard let iconURL = URL(string: iconURLString.regexReplace(pattern: pattern, replace: suffix)) else{ continue }
                    // Dataを取得して保存
                    if let iconData = try? Data(contentsOf: iconURL) {
                        print("success.")
                        let iconName = targetID
                        let iconPath = self.cachePath + "/icon/" + iconName
                        do {
                            try iconData.write(to: URL(fileURLWithPath: iconPath))
                        } catch {
                            print(error)
                        }
                        
                        self.manager.createFile(atPath: iconPath, contents: iconData, attributes: nil)
                    } else {
                        print("failed to get image")
                    }
                }
            } else {
                print("invalid icon url")
            }
        }, failure: { (error) in
            print("もはやなんなのこれ…")
            print(error)
        })
    }
}
