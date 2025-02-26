//
//  Server.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation

struct Server {
    
    static var endpoint: String {
        "https://language.googleapis.com"
    }
}


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case language = "Accept-Language"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
    case image = "image/png"
}
