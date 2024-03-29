//
//  UIViewConroller+Extension.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/30.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ message:String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func preventDoubleTap(){
//                UIView.appearance().isExclusiveTouch = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        //버튼연속클릭 방지
    }
}

