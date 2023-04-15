//
//  Font+Extension.swift
//  Me-cognize
//
//  Created by Hailey on 2023/04/01.
//

import UIKit
import SwiftUI

extension UIFont {
    static func serifLight(size: CGFloat) -> UIFont {
        UIFont(name: Font.FontFamily.SerifLight.rawValue, size: size)!
    }
    static func serifRegular(size: CGFloat) -> UIFont {
        UIFont(name: Font.FontFamily.SerifRegular.rawValue, size: size)!
    }
    
    static func checkFontFamily(){
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
}

extension Font {
    public static var defaultSize: CGFloat {
        return 16
    }
    
    enum FontFamily: String {
        case SerifLight = "NotoSerifKR-ExtraLight"
        case SerifRegular = "NotoSerifKR-Regular"
        case Verdana = "Verdana"
        case VerdanaBold = "Verdana-Bold"
        case NoteworthyLight = "Noteworthy-Light"
        case NoteworthyBold = "Noteworthy-Bold"
    }
    
    static func serifLight(size: CGFloat = defaultSize)->Font {
        return Font.custom(Font.FontFamily.SerifLight.rawValue, size: size)
    }
    
    static func serifRegular(size: CGFloat = defaultSize)->Font {
        return Font.custom(Font.FontFamily.SerifRegular.rawValue, size: size)
    }
    
    static func Verdana(size: CGFloat = defaultSize)->Font {
        return Font.custom(Font.FontFamily.Verdana.rawValue, size: size)
    }
    
    static func VerdanaBold(size: CGFloat = defaultSize)->Font {
        return Font.custom(Font.FontFamily.VerdanaBold.rawValue, size: size)
    }
    
    static func NoteworthyLight(size: CGFloat = defaultSize)->Font {
        return Font.custom(Font.FontFamily.NoteworthyLight.rawValue, size: size)
    }
    
    static func NoteworthyBold(size: CGFloat = defaultSize)->Font {
        return Font.custom(Font.FontFamily.NoteworthyBold.rawValue, size: size)
    }
    
}

extension Text {
    func race(_ font: Font.FontFamily, size: CGFloat) -> Text {
        switch font {
        case .SerifLight:
            return self.font(.serifLight(size: size))
        case .SerifRegular:
            return self.font(.serifRegular(size: size))
        case .Verdana:
            return self.font(.Verdana(size: size))
        case .VerdanaBold:
            return self.font(.VerdanaBold(size: size))
        case .NoteworthyLight:
            return self.font(.NoteworthyLight(size: size))
        case .NoteworthyBold:
            return self.font(.NoteworthyBold(size: size))
        }
    }
    
}
