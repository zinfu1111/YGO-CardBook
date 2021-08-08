//
//  BaseViewController.swift
//  BaseViewController
//
//  Created by 連振甫 on 2021/8/8.
//

import UIKit

class BaseViewController: UIViewController {

    var bgImageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackground()
    }
    
    func setupBackground() {
        
        let animatedImage = UIImage.animatedImageNamed("382b2a38a9d750ae35911b4b1fcfbf8c020cfc3dc1ea0-jH0AI8_fw658-", duration: 2)
        bgImageView?.image = animatedImage
        
    }

}
