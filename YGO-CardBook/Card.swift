//
//  Card.swift
//  Card
//
//  Created by 連振甫 on 2021/8/7.
//

import UIKit
import Foundation

enum ProblemType {
    
    case cardType
    case monCardType
    case level
    case name
    
    var problemTitle:String {
        var title = ""
        switch self {
        case .cardType:
            title = "什麼樣卡"
        case .monCardType:
            title = "怪獸屬性"
        case .level:
            title = "等級"
        case .name:
            title = "卡片名稱"
        }
        
        return "請問這張卡的\(title)"
    }
}

enum CardType:Int {
    case common = 0
    case special
    case combine
    case god
    
    var title: String {
        switch self {
        case .common:
            return "一般"
        case .special:
            return "效果"
        case .combine:
            return "融合"
        case .god:
            return "神之卡"
        }
        
    }
}

enum MonCardType:Int {
    case god = 0
    case light
    case black
    case wind
    
    var title: String {
        switch self {
        case .god:
            return "神屬性"
        case .light:
            return "光屬性"
        case .black:
            return "暗屬性"
        case .wind:
            return "風屬性"
        }
        
    }
}

struct Card:Codable {
    
    let name:String
    let level:Int
    let cardType:Int
    let monCardType:Int
    
    var type:CardType{
        return CardType(rawValue: cardType)!
    }
    
    var monType:MonCardType{
        return MonCardType(rawValue: monCardType)!
    }
    
    var image:UIImage? {
        return UIImage(named: "\(self.name)")
    }
}
