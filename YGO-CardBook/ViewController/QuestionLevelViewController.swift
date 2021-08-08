//
//  QuestionLevelViewController.swift
//  QuestionLevelViewController
//
//  Created by 連振甫 on 2021/8/8.
//

import UIKit

class QuestionLevelViewController: BaseViewController {

    @IBOutlet weak var backgroundImageView:UIImageView!
    
    var selected = 0
    var problemType:ProblemType = .cardType
    
    override func viewDidLoad() {
        self.bgImageView = backgroundImageView
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
   
    @IBAction func questionLevel(_ sender: UIButton) {
        selected = sender.tag
        
        let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        if sender.tag == 1 {
            let alertAction = UIAlertAction(title: "開始", style: .default, handler: {[self] _ in
                performSegue(withIdentifier: "goTest", sender: nil)
            })
            self.showMesssage(title: "準備開始", Msg: nil, actions: [alertAction,cancleAction])
            
        }else{
            var alertBtns = [UIAlertAction]()
            for i in 0..<ProblemType.count {
                if let selectedType = ProblemType.init(rawValue: i) {
                    let alertAction = UIAlertAction(title: "\(selectedType.problemTitle)", style: .default, handler: {[self] _ in
                        problemType = selectedType
                        performSegue(withIdentifier: "goTest", sender: nil)
                    })
                    alertBtns.append(alertAction)
                }
            }
            alertBtns.append(cancleAction)
            self.showMesssage(title: "選擇題目類型", Msg: nil, actions: alertBtns)
        }
        
        
    }
    @IBSegueAction func goTest(_ coder: NSCoder) -> QuestionViewController? {
        return QuestionViewController(coder: coder, randomQuestion: (selected == 1), problemType: problemType)
    }
}
