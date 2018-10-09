//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

protocol AlarmTableViewCellDelegate: class {
    func alarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm?{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        guard let alarm = alarm else { return}
        
        alarmTimeLabel.text = alarm.fireTimeAsString
        alarmNameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    

    @IBAction func alarmSwitchValueChanged(_ sender: Any) {
    }
}
