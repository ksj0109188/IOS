//
//  Feature.swift
//  AppStoreApp
//
//  Created by 김성준 on 2022/06/09.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
    
}
