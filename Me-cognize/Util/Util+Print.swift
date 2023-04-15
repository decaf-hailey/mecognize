//
//  Util+Print.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation



extension Util {
    
    enum Print{
        
        enum PrintType{
            case SystemError(_ message : Any?), CheckValue(_ message : Any?), None(_ message : Any?)
        }
        
        static func PrintLight(printType: PrintType) {
            var printString = ""
            switch printType {
            case .SystemError(let message):
                printString = " 🟥 SystemError : \(String(describing: message))"
            case .CheckValue(let message):
                printString = " ✅ CheckValue : \(String(describing: message))"
            case .None(let message):
                printString = " 🟦 : \(String(describing: message))"
            }
            printString.append("\n ⌊__________________ ")
            #if DEBUG
                print(printString)
            #endif
        }

    }
}
