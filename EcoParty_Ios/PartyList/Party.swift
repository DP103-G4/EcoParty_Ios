//
//  Party.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/25.
//  Copyright © 2020 Bozin. All rights reserved.
//

import Foundation

struct Party: Codable {
    var id: Int
    var name: String
    var startTime: Date
    var endTime: Date
    var postTime: Date
    var postEndTime: Date
    var location: String
    var address: String
    var longitude: Double?
    var latitude: Double?
    var content: String
    var countUpperLimit: Int
    var countLowerLimit: Int
    var countCurrent: Int
    var state: Int
    var distance: Int
    
}

struct PieceList: Codable {
    var id: Int
    //        var state: Int
    
}

struct MyPartyList: Codable {
    var id: Int
    
}

struct MyPieceList: Codable {
    var id: Int
    
}

struct CurrentPartyList: Codable {
    var id: Int
    //        var state: Int
    
}

struct PartyList: Codable {
    var id: Int
    var ownerId: Int?
    var name: String
    var startTime: Date
    var location: String
    //    var state: Int
    
}
