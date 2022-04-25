//
//  AssetMenu.swift
//  MyAssets
//
//  Created by 김성준 on 2022/04/24.
//

import Foundation

enum AssetMenu:String, Identifiable, Decodable{
    case creditscore
    case bankAccount
    case investment
    case loan
    case insurance
    case creditcard
    case cash
    case realEstate
    
    var id: String{
        return self.rawValue
    }
    
    var systemImageName: String{
        switch self{
        case .creditscore:
            return "number.circle"
        case .bankAccount:
            return "banknote"
        case .investment:
            return "bitcoinsign.circle"
        case .loan:
            return "hand.wave"
        case .insurance:
            return "lock.shield"
        case .cash:
            return "dollarsign.circle"
        case .realEstate:
            return "house.fill"
        case .creditcard:
            return "creditcard"
        }
    }
    
    var title:String{
        switch self{
        case .creditscore:
            return "신용점수"
        case .bankAccount:
            return "계좌"
        case .investment:
            return "투자"
        case .loan:
            return "대출"
        case .cash:
            return "현금영수증"
        case .creditcard:
            return "카드"
        case .insurance:
            return "보험"
        case . realEstate:
            return "부동산"
        }
    }
}
