//
//  Util.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation
enum Util {
    static func fromMock<T:Codable>(dataType: T.Type, forResource: String) ->T? {
            guard let path = Bundle.main.path(forResource: forResource, ofType: "json") else {
                return nil
            }
            guard let jsonString = try? String(contentsOfFile: path) else {
                return nil
            }
            let decoder = JSONDecoder()
            let data = jsonString.data(using: .utf8)
            if let data = data,
               let _data = try? decoder.decode(T.self, from: data) {
                return _data
            } else {
                return nil
            }

        
    }
}
