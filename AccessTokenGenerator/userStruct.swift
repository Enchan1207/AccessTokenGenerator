//
//  userStruct.swift
//  AccessTokenGenerator
//
//  Created by EnchantCode on 2020/06/19.
//  Copyright © 2020 EnchantCode. All rights reserved.
//

import Foundation

struct User: Codable {
    var screenName: String
    let userid: String
    let token: AccessToken
    let created: Int64
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: self.created))
        return formatter.string(from: date)
    }
}
