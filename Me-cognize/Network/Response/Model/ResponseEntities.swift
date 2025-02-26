//
//  ResponseEntities.swift
//  Me-cognize
//
//  Created by Hailey on 2023/03/05.
//

import Foundation

struct ResponseEntities: Codable {
    let entities: [AnalyzeEntity]
    let language: String
}

struct AnalyzeEntity: Codable {
    
    //representative name for the entity.
    let name : String
    
    let type: EntityType
    let metadata: String
    
    //The salience score associated with the entity in the [0, 1.0] range.
    let salience: Int
    let mentions: [EntityMention]
    let sentiment: Sentiment
}

enum EntityType: String, Codable {
    case UNKNOWN, PERSON, LOCATION, ORGANIZATION, EVENT, WORK_OF_ART, CONSUMER_GOOD, OTHER, PHONE_NUMBER, ADDRESS, DATE, NUMBER, PRICE
    
}

struct EntityMention: Codable {
    let text: TextSpan
    let type: MentionType
}

struct TextSpan: Codable {
    let content: String
    let beginOffset: Int
    let sentiment: Sentiment
}

enum MentionType: String, Codable {
    case TYPE_UNKNOWN, PROPER, COMMON
}
