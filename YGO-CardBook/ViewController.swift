//
//  ViewController.swift
//  YGO-CardBook
//
//  Created by 連振甫 on 2021/8/7.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var desk:[Card] = []
    var currentCard = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackground()
        setupDesk()
    }
    
    
    func setupBackground() {
        
        let animatedImage = UIImage.animatedImageNamed("382b2a38a9d750ae35911b4b1fcfbf8c020cfc3dc1ea0-jH0AI8_fw658-", duration: 2)
        backgroundImageView.image = animatedImage
        
    }

    func setupDesk()  {
        desk.removeAll()
        
        while desk.count < 10 {
            let index = Int.random(in: 0..<CardManager.shared.cards.count)
            let card = CardManager.shared.cards[index]
            
            if desk.first(where: {$0.name == card.name}) == nil {
                desk.append(card)
            }
        }
    }

}

