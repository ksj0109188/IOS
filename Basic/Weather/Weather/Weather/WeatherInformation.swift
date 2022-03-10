//
//  WeatherInformation.swift
//  Weather
//
//  Created by 김성준 on 2022/03/05.
//

import Foundation

struct WeatherInformation : Codable{
    let weather : [Weather]
    let temp : Temp
    let name: String
    
    enum CodingKeys:String, CodingKey{
        case weather
        case temp = "main"
        case name
    }
}

struct Weather : Codable{
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct Temp : Codable{
    let temp: Double
    let feelslike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey{
        case temp
        case feelslike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
