//
//  User.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/2.
//  Copyright © 2020 Bozin. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var account: String
    var password: String
    var email: String
    var name: String?
    var isOver: Bool
//    var time: Date
    
}

struct UserLogin: Codable {
    var id: Int?
}
