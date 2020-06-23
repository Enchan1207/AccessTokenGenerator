//
//  UserManager.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/22.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import RealmSwift

class UserManager: RealmClient{
    // ユーザリスト取得
    private func loadUserList() -> [userModel]?{
        guard let realm = self.getRealm() else{ return nil }
        let userListArray = Array(realm.objects(userModel.self))
        return userListArray
    }
    func getUserList() -> [userModel]?{
        guard let storedUserList = loadUserList() else{ return nil }
        return storedUserList
    }
    
    // ユーザリスト追加
    func add(user: userModel){
        try? getRealm()?.write {
            getRealm()?.add(user)
        }
    }
    
    // ユーザリスト削除
    func remove(user: userModel){
        let stmt = NSPredicate(format: "userid=%@", argumentArray:[user.userid])
        self.remove(whereStmt: stmt)
    }
    
    private func remove(whereStmt: NSPredicate){
        guard let realm = self.getRealm() else{ return }
        if let deleteTargetModel = realm.objects(userModel.self).filter(whereStmt).last {
            try? realm.write {
                realm.delete(deleteTargetModel)
            }
        }
    }
}
