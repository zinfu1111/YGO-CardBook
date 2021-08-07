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

    func getProblemAnwsers(card:Card) -> [Card] {
        
        var tmpCards = [Card]()
        while tmpCards.count < 3 {
            let index = Int.random(in: 0..<self.cards.count)
            let card = self.cards[index]
            
            if tmpCards.first(where: {$0.name == card.name}) == nil {
                tmpCards.append(card)
            }
        }
        tmpCards.append(card)
        
        return tmpCards
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
