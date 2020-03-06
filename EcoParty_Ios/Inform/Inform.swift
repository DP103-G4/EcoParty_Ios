//
//  Inform.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/25.
//  Copyright © 2020 Bozin. All rights reserved.
//

import Foundation

struct Inform: Codable {
    var id: Int
    var userId: Int
    var partyId: Int
//    var time: Date
    var content: String
    var isRead : Bool

}

