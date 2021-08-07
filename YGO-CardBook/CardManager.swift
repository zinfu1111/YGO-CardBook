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
