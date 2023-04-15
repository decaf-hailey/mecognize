//
//  Dictionary+Extension.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation

extension Dictionary {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).encodeUrl(),
                              String(describing: value).encodeParams())
            parts.append(part)
        }
        return "?"+parts.joined(separator: "&")
    }
}

