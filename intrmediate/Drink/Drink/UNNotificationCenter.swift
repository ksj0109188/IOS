//
//  UNNotificationCenter.swift
//  Drink
//
//  Created by 김성준 on 2022/03/27.
//

import Foundation
import UserNotifications

//알림은 UsertNotification에 request가 등록되면 특정 트리거를 통해 UserNotificationCenter가 notify
extension UNUserNotificationCenter{
    func addNotificationRequest(by alert:Alert){
        let content = UNMutableNotificationContent()
        content.title = "물 드세요"
        content.body = "WHO가 권정하는 하루 물 섭취량은 1.5~2리터 입니다."
        content.sound = .default
        content.badge = 1
        
        
        let component = Calendar.current.dateComponents([.hour,.minute], from: alert.date)
        //트리거 설정
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        self.add(request, withCompletionHandler: nil)
    }
    
}
