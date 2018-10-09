//
//  AlarmController.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController: AlarmScheduler {
    
    
    
    // Shared Instance
    static let sharedInstance = AlarmController()
    
    //Shared truth
    var myAlarms = [Alarm]()
    
    var alarmIsOn: Bool = false
    
    
//    init() {
//        loadFromPersistentStore()
//    }
    
    // MARK: - CRUD Functions
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(name: name, fireDate: fireDate, enabled: enabled)
        AlarmController.sharedInstance.myAlarms.append(newAlarm)
        saveToPersistent()
        scheduleUserNotifications(alarm: newAlarm)
        
    }
    
    func update(alarm: Alarm, name: String, enabled: Bool, fireDate: Date){
        alarm.name = name
        alarm.enabled = enabled
        alarm.fireDate = fireDate
        saveToPersistent()
        scheduleUserNotifications(alarm: alarm)
        
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmController.sharedInstance.myAlarms.firstIndex(of: alarm) else { return}
        self.cancelUserNotifications(alarm: alarm)
        myAlarms.remove(at: index)
    }
    
    // If user makes an alarm send notification else cancel notification
    func toggleEnabled(for alarm: Alarm){
        alarm.enabled = !alarm.enabled
        
        if alarm.enabled{
            scheduleUserNotifications(alarm: alarm)
        }else {
            cancelUserNotifications(alarm: alarm)
        }
    }
    
    //MARK: Saving and loading
    func fileURL() -> URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "alarm.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    func saveToPersistent() {
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(myAlarms)
            try data.write(to: fileURL())
        }catch let error {
            print("There was an error saving \(error)")
        }
    }
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            self.myAlarms = alarms
        }catch let error {
            print("There was an error loading \(error)")
        }
    }
}

protocol AlarmScheduler: class {
    func scheduleUserNotifications(alarm: Alarm)
    func cancelUserNotifications(alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Time to get up"
        content.body = "Your alarm named \(alarm.name) is going off!"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")
            }
        }
    }
  
    
    func cancelUserNotifications(alarm: Alarm) {
UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}
