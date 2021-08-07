//
//  ViewController.swift
//  YGO-CardBook
//
//  Created by 連振甫 on 2021/8/7.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var answerButtons:[UIButton]!
    @IBOutlet weak var cardImageView:UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var desk:[Card] = []
    var currentCard = 0
    var problemType:ProblemType = .cardType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackground()
        setupDesk()
        setupQA()
    }
    
    
    func setupBackground() {
        
        let animatedImage = UIImage.animatedImageNamed("382b2a38a9d750ae35911b4b1fcfbf8c020cfc3dc1ea0-jH0AI8_fw658-", duration: 2)
        backgroundImageView.image = animatedImage
        
    }

    func setupDesk() {
        desk.removeAll()
        
        while desk.count < 10 {
            let index = Int.random(in: 0..<CardManager.shared.cards.count)
            let card = CardManager.shared.cards[index]
            
            if desk.first(where: {$0.name == card.name}) == nil {
                desk.append(card)
            }
        }
    }
    
    func setupQA() {
        let card = desk[currentCard]
        cardImageView.image = card.image
        problemType = ProblemType.random()
        let tmpAnwsers = CardManager.shared.getProblemAnwsers(card: desk[currentCard])
        var anwsers = [Card]()
        
        while anwsers.count < 4 {
            let index = Int.random(in: 0..<tmpAnwsers.count)
            let card = tmpAnwsers[index]
            if anwsers.first(where: {$0.name == card.name}) == nil {
                anwsers.append(card)
            }
        }
        setupQAButton(cards: anwsers)
        
    }
    
    func setupQAButton(cards:[Card]) {
        print(cards)
        for button in answerButtons {
            
            switch problemType {
            case .cardType:
                button.setTitle(cards[button.tag].type.title, for: .normal)
            case .monCardType:
                button.setTitle(cards[button.tag].monType.title, for: .normal)
            case .level:
                button.setTitle("等級\(cards[button.tag].level)", for: .normal)
            case .name:
                button.setTitle("\(cards[button.tag].name)", for: .normal)
            }
        }
        
    }

}

