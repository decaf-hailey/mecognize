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
                 response(router: String, _ data : Data?),
                 responseError(router: String, _ message : Any?),
                 none(_ message : Any?)
            
        }
        
        static func PrintLight(printType: PrintType) {
#if DEBUG
            var printString : String = ""
            switch printType {
            case .systemError(let message):
                printString = " 🟥 SystemError : \(String(describing: message))"
            case .checkValue(let message):
                printString = " ✅ CheckValue : \(String(describing: message))"
            case .response(let router, let data):
                guard let _data = data else {
                    printString = #"""
                    🟢 router: \#(router)
                    message: data = nil
                    """#
                    return
                }
                printString = #"""
                🟢 router: \#(router)
                message: \#(String(data: _data, encoding: .utf8) ?? "")
                """#
                
            case .responseError(let router, let message):
                printString = #"""
                🟢 router: \#(router)
                message: \#(String(describing: message))
                """#
                
            case .none(let message):
                printString = " 🟣 : \(String(describing: message))"
            }
            printString.append("\n ⌊__________________ ")
            print(printString)
#endif
        }
        
    }
}
