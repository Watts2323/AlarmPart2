//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    @IBOutlet weak var datePickerLabel: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmEnabledButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var alarmIsOn: Bool = true

    var alarm: Alarm?{
        didSet{
            updateViews()
            loadViewIfNeeded()
        }
    }
    
    func updateViews(){
        guard let alarm = alarm else { return}
        datePickerLabel.date = alarm.fireDate
        alarmIsOn = alarm.enabled
        alarmNameTextField.text = alarm.name
        setUpAlarmButton()
        
    }
    
    func setUpAlarmButton(){
        
        switch alarmIsOn {
        case true:
            alarmEnabledButton.backgroundColor = UIColor.yellow
            alarmEnabledButton.setTitle("ON", for: .normal)
        case false:
            alarmEnabledButton.backgroundColor = UIColor.gray
            alarmEnabledButton.setTitle("Off", for: .normal)
        }
    }
    
    
    @IBAction func alarmEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.sharedInstance.toggleEnabled(for: alarm)
            alarmIsOn = alarm.enabled
        }else{
            alarmIsOn != alarmIsOn
        }
        setUpAlarmButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmNameTextField.text else {return}
        guard title != "" else {return}
        
        if let alarm = alarm{
            AlarmController.sharedInstance.update(alarm: alarm, name: title, enabled: alarmIsOn, fireDate: datePickerLabel.date)
        } else{
            AlarmController.sharedInstance.addAlarm(fireDate: datePickerLabel.date, name: title, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
