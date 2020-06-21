//
//  userModel.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/21.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import RealmSwift

class userModel: Model {
    @objc dynamic var users: [User]
}
