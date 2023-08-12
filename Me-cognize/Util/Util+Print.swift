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
            case systemError(_ message : Any?),
                 checkValue(_ message : Any?),
                 response(_ message : Any?),
                 responseError(_ message : Any?),
                 none(_ message : Any?)
            
        }
        
        static func PrintLight(printType: PrintType) {
        #if DEBUG
            var printString = ""
            switch printType {
            case .systemError(let message):
                printString = " 🟥 SystemError : \(String(describing: message))"
            case .checkValue(let message):
                printString = " ✅ CheckValue : \(String(describing: message))"
            case .response(let message):
                printString = " 🟢 response : \(String(describing: message))"
            case .responseError(let message):
                printString = " 🟡 responseError : \(String(describing: message))"
            case .none(let message):
                printString = " 🟣 : \(String(describing: message))"
            }
            printString.append("\n ⌊__________________ ")
            print(printString)
        #endif
        }

    }
}
