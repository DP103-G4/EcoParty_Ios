//
//  PartyInfo.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/9.
//  Copyright © 2020 Bozin. All rights reserved.
//

import Foundation

struct PartyInfo: Codable {
    var party: Party
    var ownerName: String
    var isIn: Bool
    var isLike: Bool
    var isStaff: Bool
    
}
