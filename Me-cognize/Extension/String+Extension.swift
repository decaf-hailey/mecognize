//
//  String+Extension.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation


extension String {
    
    
    func replace(target: String?, withString: String) -> String {
        guard let _target = target else {
            return self
        }
        return self.replacingOccurrences(of: _target, with: withString, options: .literal, range: nil)
    }
    
    
    
    
    // 네트워크 관련 ref: https://eddiekwon.github.io/swift/2018/09/01/Encoding101/
    /// ## 🚨중복이나 겹쳐서 쓰이지 않도록 주의 ##
     func encodeUrl() -> String {
        // !$&’()*+,-./:;=?@_~를 걸러줌
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    /// ## 🚨중복이나 겹쳐서 쓰이지 않도록 주의 ##
     func encodeParams() -> String {
        //문자가 겹치지 않는다고 해서 윗 함수들과 연결해서 쓰지 않도록 = 단독사용
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!\"#%&()+\\,./;:<>=$?@^{}[]'’|*-_~").inverted) ?? ""
    }
    
    //    사용하지 않는다.
    //    fileprivate func urlDecode() -> String {
    //        return self.removingPercentEncoding!
    //    }
    
}


public extension Substring {
        /// Convert a `Substring` to a valid `String`
    var toString: String {
        return String(self)
    }
    
 
}

public extension Character {
        /// Convert a `Substring` to a valid `String`
    var toString: String {
        return String(self)
    }
}
extension Int {
    func toString()-> String {
        return String(describing: self).replace(target: ",", withString: "")
    }
}

extension Double {
    func toString()-> String {
        return String(describing: self).replace(target: ",", withString: "")
    }
}
