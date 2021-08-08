//
//  Ext+UIViewController.swift
//  Ext+UIViewController
//
//  Created by 連振甫 on 2021/8/8.
//

import Foundation
import UIKit

extension UIViewController {
    func showMesssage(title: String? = nil,Msg:String? = nil, actions:[UIAlertAction]) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: Msg, preferredStyle: .alert)
            actions.forEach({
                alertVC.addAction($0)
            })
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
