//
//  ResponseSentiment.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation

struct ResponseSentiment: Codable {
    let documentSentiment: Sentiment
    let language: String
//    let sentences: [Sentence]
}


struct Sentence: Codable {
    let text: String
    let sentiment: Sentiment
}

struct Sentiment: Codable {
    let magnitude: Float
    let score: Double
}
