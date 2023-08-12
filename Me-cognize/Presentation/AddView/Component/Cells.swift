//
//  AddVariableCell.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/09.
//

import Foundation
import UIKit

class AddTypingCell : MeTableViewCell, UITextViewDelegate {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var textView: MeTextView!
    
    var textChanged: ((String)->())?
    //    var textViewEditing: (()->())?
    
    
    let reasonPlaceholder = "Write your story in 5 to 100 characters"
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textViewPlaceholder(sender: textView)
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //커서 위치로 스크롤한다
        textView.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
        
        
        let size = CGSize(width: baseView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height > 70  && constraint.firstAttribute == .height{
                constraint.constant = estimatedSize.height
                
            }
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.count > 100 && !(text == "") {
            ///팝업?
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textViewPlaceholder(sender: textView)
        } else {
            textChanged?(textView.text)
        }
    }
    
    func textViewPlaceholder(sender: UITextView){
        if sender.text == "" {
            sender.textColor = UIColor.gray
            sender.text = reasonPlaceholder
            return
        }
        if sender.text == reasonPlaceholder {
            sender.text = ""
            sender.textColor = UIColor.black
            return
        }
        sender.textColor = UIColor.black
        
    }
    
}


class AddResultCell : MeTableViewCell {
    
    @IBOutlet var label: MeLightLabel!
    
    
    func config(_ data: Sentiment?){
        guard let data = data else {
            label.text = "Trying sending your today!"
            return
        }
        label.text = String(describing: data)
    }
    
}

