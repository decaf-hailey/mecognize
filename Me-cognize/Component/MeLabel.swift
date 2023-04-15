//
//  MeLabel.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/01.
//

import UIKit
import SwiftUI

class MeLightLabel: UILabel {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.font = UIFont.serifLight(size: 16)
    }
}


extension MeLightLabel {
    @IBInspectable
    open var fontSize: CGFloat {
        get {
            return Font.defaultSize
        } set {
            self.font = UIFont.serifLight(size: newValue)
        }
    }
}

class MeRegularLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.font = UIFont.serifRegular(size: 16)
    }
}


extension MeRegularLabel {
    @IBInspectable
    open var fontSize: CGFloat {
        get {
            return Font.defaultSize
        } set {
            self.font = UIFont.serifRegular(size: newValue)
        }
    }
}


extension UILabel {
    
    @IBInspectable
    open var kern: CGFloat {
        get {
            return 1
        } set {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }

}
