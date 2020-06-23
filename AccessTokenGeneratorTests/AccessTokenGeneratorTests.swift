//
//  AccessTokenGeneratorTests.swift
//  AccessTokenGeneratorTests
//
//  Created by EnchantCode on 2020/06/20.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import XCTest
@testable import AccessTokenGenerator

class AccessTokenGeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // ユーザ追加
    func testUserGenerate() {
        let manager = UserManager()
        let user = userModel(screenName: "screenName", userid: NSUUID().uuidString, token: AccessToken(key: "token", secret: "secret"))
        manager.add(user: user)
    }
    
    // 全ユーザ削除
    func testDeleteAllAccessToken(){
        let manager = UserManager()
        manager.getRealm()?.objects(userModel.self).forEach({ (user) in
            try? manager.getRealm()?.write {
                manager.getRealm()?.delete(user)
            }
        })
        
    }
    
    // 全ユーザ取得
    func testGetAllTokens(){
        print(UserManager().getUserList())
    }
    
    // アイコンフェッチ
    func testIconFetch(){
        let token = AccessToken(key: "1184828739009429504-IU6psdEH0yTCEFnQOg5SyXbkoekuhO", secret: "1XgTZWe18cB5R9jilgo2dN9pADS7kRjW9snRKGDu6iulE")
        let user = userModel(screenName: "ImaginaryJK", userid: "1184828739009429504", token: token)
        IconFetcher(token: token).fetch(user: user)
        
        print(user.getIconImage())
    }
    
    // 文字列置き換え
    func testStringRepl(){
        let url = "https://twitter.com/statuses/image/0/114514_normal.png"
        let pattern = "https://(.+)_normal(.+)$"
        let replace = "https://$1_200x200$2"
        print(url.regexReplace(pattern: pattern, replace: replace))
    }
    
    // デバイスディレクトリ
    func testgetDeviceDir(){
        let documentDirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(documentDirPath)
    }
    
    // 何かがおかしい
    func testWriteToFile(){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
        let fileObject = "sample"
        let fileName = "file.txt"
        let filePath = documentsPath + fileName

        // 保存処理
        do {
            try fileObject.write(toFile: filePath, atomically: true, encoding: .utf8)
            print(documentsPath)
            print(FileManager().urls(for: .cachesDirectory, in: .userDomainMask)[0])
        } catch {
            print(error)
        }
    }
}
