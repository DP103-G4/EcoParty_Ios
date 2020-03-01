//
//  News.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/27.
//  Copyright © 2020 Bozin. All rights reserved.
//

import Foundation

struct News: Codable {
    var id: Int
    var title: String
    var content: String
    var time: Date?
    
    var dateStr: String {
        if time != nil {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return format.string(from: time!)
        } else {
            return ""
        }
    }
    
}

