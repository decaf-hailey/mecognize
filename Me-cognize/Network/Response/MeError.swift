//
//  MeError.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation

//various customizing
public enum MeError: Error, Identifiable, Hashable {
    public var id: Int {
        hashValue
    }
    //MARK: - server-side
    case disconnected
    case httpError(errorCode: Int, reason: String)
    case authError(errorCode: Int)
    case resultNil(errorCode: Int)
    case resultError(errorCode: Int, reason: String)
    case jsonParsingError(reason: String)
    
    //MARK: - client-side
//    case invalidEndpoint
//    case decodeFailure
//    case needApiKey
    case saveFailed(reason: String)
    
    case custom(reason: String)

    public var reason: String {
        switch self {
        case .disconnected:
            return "Failed to make HTTPURLResponse"
        case .httpError(let errorCode, let reason):
            return "(\(errorCode)), \(reason)"
        case .authError:
            return "Need to login"
        case .resultNil(let errorCode):
            return "(\(errorCode)), respone success but data is empty"
        case .resultError(_, let reason):
            return reason
        case .jsonParsingError(let reason):
            return "Failed to decode/generate JSON from data \(reason)"
        case .saveFailed:
            return "Failed to save history data"
        case .custom(let reason):
            return reason
        }
        
    }
}

