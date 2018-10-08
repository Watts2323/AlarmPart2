//
//  Alarm.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

class Alarm {
    var name: String
    var fireDate: Date
    var uuid: String
    var enabled: Bool
    
    init(name: String, fireDate: Date, uuid: String = UUID() .uuidString, enabled: Bool) {
        self.name = name
        self.fireDate = fireDate
        self.enabled = enabled
        self.uuid = uuid
        
        
        var fireDateAsString: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter.string(from: fireDate)
        }
    }
}
