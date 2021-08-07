//
//  QuestionLevelViewController.swift
//  QuestionLevelViewController
//
//  Created by 連振甫 on 2021/8/8.
//

import UIKit

class QuestionLevelViewController: UIViewController {

    @IBOutlet weak var backgroundImageView:UIImageView!
    
    var selected = 0
    var problemType:ProblemType = .cardType
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackground()
    }
    
    func setupBackground() {
        
        let animatedImage = UIImage.animatedImageNamed("382b2a38a9d750ae35911b4b1fcfbf8c020cfc3dc1ea0-jH0AI8_fw658-", duration: 2)
        backgroundImageView.image = animatedImage
        
    }
    @IBAction func questionLevel(_ sender: UIButton) {
        selected = sender.tag
        
        if sender.tag == 1 {
            let alertVC = UIAlertController(title: "準備開始", message: nil, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "開始", style: .default, handler: {[self] _ in
                performSegue(withIdentifier: "goTest", sender: nil)
            })
            let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            
            alertVC.addAction(alertAction)
            alertVC.addAction(cancleAction)
            
            self.present(alertVC, animated: true, completion: nil)
        }else{
            
            let alertVC = UIAlertController(title: "選擇題目類型", message: nil, preferredStyle: .alert)
            
            let alertAction1 = UIAlertAction(title: "\(ProblemType.name.problemTitle)", style: .default, handler: {[self] _ in
                problemType = .name
                performSegue(withIdentifier: "goTest", sender: nil)
            })
            let alertAction2 = UIAlertAction(title: "\(ProblemType.monCardType.problemTitle)", style: .default, handler: {[self] _ in
                problemType = .monCardType
                performSegue(withIdentifier: "goTest", sender: nil)
            })
            let alertAction3 = UIAlertAction(title: "\(ProblemType.level.problemTitle)", style: .default, handler: {[self] _ in
                problemType = .level
                performSegue(withIdentifier: "goTest", sender: nil)
            })
            let alertAction4 = UIAlertAction(title: "\(ProblemType.cardType.problemTitle)", style: .default, handler: {[self] _ in
                problemType = .cardType
                performSegue(withIdentifier: "goTest", sender: nil)
            })
            let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            
            alertVC.addAction(alertAction1)
            alertVC.addAction(alertAction2)
            alertVC.addAction(alertAction3)
            alertVC.addAction(alertAction4)
            alertVC.addAction(cancleAction)
            
            self.present(alertVC, animated: true, completion: nil)
        }
        
        
    }
    @IBSegueAction func goTest(_ coder: NSCoder) -> QuestionViewController? {
        return QuestionViewController(coder: coder, randomQuestion: (selected == 1), problemType: problemType)
    }
}
