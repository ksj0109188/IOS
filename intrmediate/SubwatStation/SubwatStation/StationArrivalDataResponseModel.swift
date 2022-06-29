//
//  StationArrivalDataResponseModel.swift
//  SubwatStation
//
//  Created by 김성준 on 2022/06/29.
//

import Foundation

struct StationArrivalDataResponseModel: Decodable {
    var realtimeStationArrival : [RealTimeArrival] = []
    
    struct RealTimeArrival : Decodable{
        
        let line: String
        let remainTime: String
        let currentStation: String
        
        enum CodingKeys: String, CodingKey{
            case line = "trainLinNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}


