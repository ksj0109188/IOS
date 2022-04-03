//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Created by 김성준 on 2022/03/31.
//

import UIKit

struct Content : Decodable {
    let seciontType : SecionType
    let sectionName : String
    let contentItem : [Item]
    
    enum SecionType:String, Decodable{
        case basic
        case main
        case large
        case rank
    }
}

struct Item : Decodable{
    let description : String
    let imageName : String
    
    var image:UIImage{
        return UIImage(named: imageName) ?? UIImage()
    }
    
}
