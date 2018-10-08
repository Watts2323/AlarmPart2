//
//  AlarmController.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

class AlarmController {
    
    
    // Shared Instance
    static let sharedInstance = AlarmController()
    
    //Shared truth
    var myAlarms: [Alarm]
    
    // MARK: - CRUD Functions
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        
    }
    
    func update(alarm: Alarm, name: String, enabled: Bool){
        
    }
    
    func delete(alarm: Alarm) {
        
    }
}
