//
//  Alarm.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var name: String
    var fireDate: Date
    var uuid: String
    var enabled: Bool
    
    init(name: String, fireDate: Date, uuid: String = UUID() .uuidString, enabled: Bool = false) {
        self.name = name
        self.fireDate = fireDate
        self.enabled = enabled
        self.uuid = uuid
        
        
    }
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    }
    
    
    
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        if lhs.name != rhs.name { return false}
        if lhs.fireDate != rhs.fireDate { return false}
        if lhs.enabled != rhs.enabled { return false}
        if lhs.uuid != rhs.uuid { return false}
        return true
    }
    
    
}
