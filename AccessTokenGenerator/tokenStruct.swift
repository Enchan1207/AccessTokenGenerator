//
//  tokenStruct.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation

struct AccessToken: Codable {
    let key: String
    let secret: String
}
