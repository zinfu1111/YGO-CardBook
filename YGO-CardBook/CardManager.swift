//
//  CardManager.swift
//  CardManager
//
//  Created by 連振甫 on 2021/8/7.
//

import UIKit
import Foundation

class CardManager {
    
    static let shared = CardManager()
    
    var cards = [Card]()
    
    init() {
        cards = load("cardData")
    }

    func getNameAnwsers(card:Card) -> [Card] {
        
        var tmpCards = [Card]()
        tmpCards.append(card)
        while tmpCards.count < 4 {
            let index = Int.random(in: 0..<self.cards.count)
            let card = self.cards[index]
            
            if tmpCards.first(where: {$0.name == card.name}) == nil {
                tmpCards.append(card)
            }
        }
        
        return tmpCards
    }
    
    func getLevelAnwsers(card:Card) -> [Int] {
        
        var tmpLevel = [Int]()
        tmpLevel.append(card.level)
        while tmpLevel.count < 4 {
            let level = Int.random(in: 1...12)
            
            if tmpLevel.first(where: {$0 == level}) == nil {
                tmpLevel.append(level)
            }
        }
        
        return tmpLevel
    }
    
    func getCardTypeAnwsers(card:Card) -> [Int] {
        
        var tmpCardTypes = [Int]()
        tmpCardTypes.append(card.cardType)
        while tmpCardTypes.count < 4 {
            let cardType = Int.random(in: 0...3)
            
            if tmpCardTypes.first(where: {$0 == cardType}) == nil {
                tmpCardTypes.append(cardType)
            }
        }
        
        return tmpCardTypes
    }
    
    func getMonCardTypeAnwsers(card:Card) -> [Int] {
        
        var tmpMonCardTypes = [Int]()
        tmpMonCardTypes.append(card.monCardType)
        while tmpMonCardTypes.count < 4 {
            let monCardType = Int.random(in: 0...3)
            
            if tmpMonCardTypes.first(where: {$0 == monCardType}) == nil {
                tmpMonCardTypes.append(monCardType)
            }
        }
        
        return tmpMonCardTypes
    }

    func load<T: Decodable>(_ filename: String) -> T {
        guard let data = NSDataAsset(name: filename)?.data else {
            fatalError("Couldn't load \(filename) from asset")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
