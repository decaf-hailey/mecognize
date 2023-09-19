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
    @IBOutlet var textCountLabel: MeLightLabel!
    var textChanged: ((String)->())?
    
    let reasonPlaceholder = "Write your story in 5 to 200 characters"

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func config(first: Bool, isSent: Bool){
        textViewPlaceholder(isFirst: first, isSent: isSent)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //커서 위치로 스크롤한다
        textView.becomeFirstResponder()
        
        if textView.text == reasonPlaceholder {
            textViewPlaceholder(isFirst: false, isSent: false)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
        
        let size = CGSize(width: baseView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height > 70  && constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
                
            }
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let count = textView.text.count+text.count
        textCountLabel.text = count.toString()
        if count > 200 && !(text == "") {
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textViewPlaceholder(isFirst: true, isSent: false)
        } else {
            textChanged?(textView.text)
        }
    }
    
    func textViewPlaceholder(isFirst: Bool, isSent: Bool){
        if isFirst {
            textView.textColor = UIColor.gray
            textView.text = reasonPlaceholder
            return
        } else if isSent {
            return
        } else {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        textView.textColor = UIColor.black
    }
    
}


class AddResultCell : MeTableViewCell {
    
    @IBOutlet var label: MeLightLabel!
    
    func config(_ data: Sentiment?){
        guard let data = data else {
            label.text = "Try sending your today!"
            return
        }
        label.text = String(describing: data)
    }
    
}

