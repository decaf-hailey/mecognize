//
//  MeLabel.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/01.
//

import UIKit
import SwiftUI

// MARK: - MeLightLabel, MeRegularLabel
class MeLightLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.font = UIFont.serifLight(size: 16)

    }
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

class MeRegularLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.font = UIFont.serifRegular(size: 16)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

class MeTextView : UITextView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.font = UIFont.serifLight(size: 16)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

    }
}

// MARK: - IBInspectable ----------------------------------------------------
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


extension MeTextView {
    @IBInspectable
    open var fontSize: CGFloat {
        get {
            return Font.defaultSize
        } set {
            self.font = UIFont.serifLight(size: newValue)
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




