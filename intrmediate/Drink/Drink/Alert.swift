//
//  Alert.swift
//  Drink
//
//  Created by 김성준 on 2022/03/27.
//

import Foundation

struct Alert:Codable {
    var id:String = UUID().uuidString
    var date:Date
    var isOn:Bool
    
    var time:String{
        let timeFormmater = DateFormatter()
        timeFormmater.dateFormat = "hh:mm"
        return timeFormmater.string(from: date)
    }
    
    var meridiem : String{
        let merdiemFormatter = DateFormatter()
        merdiemFormatter.dateFormat = "a"
        merdiemFormatter.locale = Locale(identifier: "ko")
        return merdiemFormatter.string(from: date)
    }
}
