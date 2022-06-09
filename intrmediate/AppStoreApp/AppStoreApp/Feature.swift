//
//  Feature.swift
//  AppStoreApp
//
//  Created by 김성준 on 2022/06/09.
//

import Foundation

struct Feature: Decodable {
    let title: String
    let subTitle: String
    let description: String
    let imageURL: String
}
