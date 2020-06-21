//
//  RealmClient.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/21.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import RealmSwift

class RealmClient {
    private var realm: Realm?
    
    init(){
        do {
            try realm = Realm()
        } catch  {
            var config = Realm.Configuration()
            config.deleteRealmIfMigrationNeeded = true
            realm = try! Realm(configuration: config)
        }
    }
    
    public func getRealm() -> Realm? {
        return self.realm
    }
    
}
