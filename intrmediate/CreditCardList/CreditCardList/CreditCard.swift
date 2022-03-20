//
//  CreditCard.swift
//  CreditCardList
//
//  Created by 김성준 on 2022/03/20.
//

import Foundation

struct CreditCard : Codable {
    let id : Int
    let rank : Int
    let name : String
    let cardImageURL : String
    let promotionDetail: PromotionDetail
    let isElected: Bool?
}

struct PromotionDetail : Codable{
    let companyName : String
    let amount : Int
    let period : String
    let benefitDate : String
    let benefitdetail : String
    let benefitCondition : String
    let condition : String
}
