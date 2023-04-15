//
//  Document.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation

struct Document : Codable {
    let content: String
    let language: String
    let type: String
    
//    init(content: String) {
//        self.content = content
//        self.language = "en"
//        self.type = DocumentType.PLAIN_TEXT.rawValue
//    }

//    let gcsContentUri: String
}

enum DocumentType: String, Codable {
    case TYPE_UNSPECIFIED
    case PLAIN_TEXT
    case HTML
}

enum EncodingType: String, Codable {
    case NONE
    case UTF8
    case UTF16
}
