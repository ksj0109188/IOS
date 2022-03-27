//
//  alertListCell.swift
//  Drink
//
//  Created by 김성준 on 2022/03/27.
//

import UIKit
import UserNotifications
class alertListCell: UITableViewCell {

    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    let notificationCenter = UNUserNotificationCenter.current()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBAction func alertSwitchValueChange(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {return}
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts),forKey: "alerts")
     
        if sender.isOn{
            self.notificationCenter.addNotificationRequest(by: alerts[sender.tag])
        }else{
            self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
}
