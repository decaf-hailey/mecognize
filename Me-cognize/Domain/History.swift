//
//  History.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/09.
//

import Foundation

/// from ResponseSentiment
class History : Codable {
    let magnitude: Float
    let score: Double
    let text: String
    let date: Date
    let title: String
    
    init(magnitude: Float, score: Double, text: String?) {
        self.magnitude = magnitude
        self.score = score
        self.text = text ?? ""
        self.date = Date()
        self.title = Util.DateConverter.getDateString(.dayMMM, date: self.date)
    }
    
}

//class Histories : Codable {
//     let date: Date = Date()
//     let list: List<History> = List<History>()
//
//}
