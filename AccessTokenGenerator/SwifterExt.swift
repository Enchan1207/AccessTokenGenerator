//
//  SwifterExt.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/22.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation
import Swifter

extension Swifter {
    convenience init(apikey: APIKey, accesstoken: AccessToken? = nil){
        if let token = accesstoken {
            self.init(consumerKey: apikey.key, consumerSecret: apikey.secret, oauthToken: token.key, oauthTokenSecret: token.secret)
        }else{
            self.init(consumerKey: apikey.key, consumerSecret: apikey.secret)
        }
    }
}
