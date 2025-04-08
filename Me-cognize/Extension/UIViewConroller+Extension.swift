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
        Task {
            await MainActor.run { [weak self] in
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                self?.view.endEditing(true)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func hideKeyboardWhenTappedAround() {
        Task{
            await MainActor.run {
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //        tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        Task{
            await MainActor.run {
                view.endEditing(true)
            }
        }
    }
    
    @objc func doubleTapped() {
        //prevent from abusing double tap
    }
    
    func preventDoubleTap(){
        Task{
            await MainActor.run {
                //                UIView.appearance().isExclusiveTouch = true
                        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
                        tap.numberOfTapsRequired = 2
                        view.addGestureRecognizer(tap)
            }
        }
    }
    
}

