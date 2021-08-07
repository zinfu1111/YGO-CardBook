//
//  QuestionViewController.swift
//  YGO-CardBook
//
//  Created by 連振甫 on 2021/8/7.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet var blurViews: [UIVisualEffectView]!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var answerButtons:[UIButton]!
    @IBOutlet weak var cardImageView:UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var desk:[Card] = []
    var currentCard = 0
    var problemType:ProblemType = .cardType
    var score = 0
    
    let randomQuestion: Bool
    
    
    init?(coder:NSCoder, randomQuestion:Bool, problemType: ProblemType) {
        self.problemType = problemType
        self.randomQuestion = randomQuestion
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackground()
        setupDesk()
        setupQAHeader()
        setupQAButton()
        scoreLabel.isHidden = true
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        
        var result = false
        
        switch problemType {
        case .cardType:
            if let answerText = sender.titleLabel?.text, desk[currentCard].type.title.elementsEqual(answerText) {
                score += 10
                result = true
            }
        case .monCardType:
            if let answerText = sender.titleLabel?.text, desk[currentCard].monType.title.elementsEqual(answerText) {
                score += 10
                result = true
            }
        case .level:
            if let answerText = sender.titleLabel?.text, "等級\(desk[currentCard].level)".elementsEqual(answerText) {
                score += 10
                result = true
            }
        case .name:
            if let answerText = sender.titleLabel?.text, "\(desk[currentCard].name)".elementsEqual(answerText) {
                score += 10
                result = true
            }
        }
        scoreLabel.text = "\(score)"
        
        if currentCard < desk.count - 1 {
            
            UIView.animate(withDuration: 1, animations: {[self] in
                blurViews.forEach({$0.alpha = 0})
                
                
                let alertVC = UIAlertController(title: result ? "答對":"答錯", message: "前往下一題", preferredStyle: .alert)
                let checkAction = UIAlertAction(title: "確認", style: .default, handler: { [self] _ in
                    
                    currentCard += 1
                    setupQAHeader()
                    setupQAButton()
                })
                alertVC.addAction(checkAction)
                self.present(alertVC, animated: true, completion: nil)
            })
            
            
        }else{
            UIView.animate(withDuration: 1, animations: {[self] in
                blurViews.forEach({$0.alpha = 0})
                
                let alertVC = UIAlertController(title: "作答結束", message: "滿分100，您的分數為\(score)分", preferredStyle: .alert)
                let checkAction = UIAlertAction(title: "確認", style: .default, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                })
                alertVC.addAction(checkAction)
                self.present(alertVC, animated: true, completion: nil)
                
            })
        }
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
    
    func setupQAHeader() {
        
        blurViews.forEach({$0.alpha = 1})
        let card = desk[currentCard]
        cardImageView.image = card.image
        problemType = randomQuestion ? ProblemType.random() : problemType
        titleLabel.text = "目前題數：\(currentCard+1)\n\(problemType.problemTitle)"
        
        
    }
    
    
    
    func setupQAButton() {
        
        func createCardTypeQABtn(){
            let tmpAnwsers = CardManager.shared.getCardTypeAnwsers(card: desk[currentCard])
            var anwsers = [Int]()
            
            while anwsers.count < 4 {
                let index = Int.random(in: 0..<tmpAnwsers.count)
                let cardType = tmpAnwsers[index]
                if anwsers.first(where: {$0 == cardType}) == nil {
                    anwsers.append(cardType)
                }
            }
            
            for button in answerButtons {
                button.setTitle("\(CardType(rawValue: anwsers[button.tag])?.title ?? "")", for: .normal)
            }
        }
        
        func createMonCardTypeQABtn(){
            let tmpAnwsers = CardManager.shared.getMonCardTypeAnwsers(card: desk[currentCard])
            var anwsers = [Int]()
            
            while anwsers.count < 4 {
                let index = Int.random(in: 0..<tmpAnwsers.count)
                let monCardType = tmpAnwsers[index]
                if anwsers.first(where: {$0 == monCardType}) == nil {
                    anwsers.append(monCardType)
                }
            }
            
            for button in answerButtons {
                
                button.setTitle("\(MonCardType(rawValue: anwsers[button.tag])?.title ?? "")", for: .normal)
            }
        }
        
        func createLevelQABtn(){
            
            let tmpAnwsers = CardManager.shared.getLevelAnwsers(card: desk[currentCard])
            var anwsers = [Int]()
            
            while anwsers.count < 4 {
                let index = Int.random(in: 0..<tmpAnwsers.count)
                let level = tmpAnwsers[index]
                if anwsers.first(where: {$0 == level}) == nil {
                    anwsers.append(level)
                }
            }
            
            for button in answerButtons {
                
                button.setTitle("等級\(anwsers[button.tag])", for: .normal)
            }
        }
        
        func createNameQABtn() {
            
            let tmpAnwsers = CardManager.shared.getNameAnwsers(card: desk[currentCard])
            var anwsers = [Card]()
            
            while anwsers.count < 4 {
                let index = Int.random(in: 0..<tmpAnwsers.count)
                let card = tmpAnwsers[index]
                if anwsers.first(where: {$0.name == card.name}) == nil {
                    anwsers.append(card)
                }
            }
            
            for button in answerButtons {
                button.setTitle("\(anwsers[button.tag].name)", for: .normal)
            }
        }
        
        
        switch problemType {
        case .cardType:
            createCardTypeQABtn()
        case .monCardType:
            createMonCardTypeQABtn()
        case .level:
            createLevelQABtn()
        case .name:
            createNameQABtn()
        }
    }

}

