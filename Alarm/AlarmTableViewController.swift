//
//  AlarmTableViewController.swift
//  Alarm
//
//  Created by Xavier on 10/8/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class AlarmTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.myAlarms.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell
        
        let alarm = AlarmController.sharedInstance.myAlarms[indexPath.row]
        
        cell?.alarm = alarm
        cell?.delegate = self

        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.sharedInstance.myAlarms[indexPath.row]
            AlarmController.sharedInstance.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmVC" {
            if let destinationVC = segue.destination as? AlarmDetailTableViewController{
                guard let selectedIndex = tableView.indexPathForSelectedRow else {return}
                    let alarms = AlarmController.sharedInstance.myAlarms[selectedIndex.row]
                destinationVC.alarm = alarms
            }
        }
    }

}

extension AlarmTableViewController: AlarmTableViewCellDelegate, AlarmScheduler {
    func alarmWasToggled(sender: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let alarm = AlarmController.sharedInstance.myAlarms[indexPath.row]
        AlarmController.sharedInstance.toggleEnabled(for: alarm)
        
        var dateComponents = DateComponents()
        dateComponents.day = 5
        dateComponents.hour = 7
    }
    
    
}
