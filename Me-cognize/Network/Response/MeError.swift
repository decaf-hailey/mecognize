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
    case disconnected
    case httpError(errorCode: Int, reason: String)
    case authError(errorCode: Int)
    case resultNil(errorCode: Int)
    case resultError(errorCode: Int, reason: String)
    case jsonParsingError(reason: String)
    case custom(reason: String)

    public var reason: String {
        switch self {
        case .disconnected:
            return "연결이 끊겼습니다. 네트워크를 확인해주세요."
        case .httpError(let errorCode, let reason):
            return "(\(errorCode)), \(reason)"
        case .authError:
            return "로그인이 필요합니다."
        case .resultNil(let errorCode):
            return "(\(errorCode)), 결과가 없습니다."
        case .resultError(_, let reason):
            return reason
        case .jsonParsingError(let reason):
            return "올바른 형식이 아닙니다. \(reason)"
        case .custom(let reason):
            return reason
        }
        
    }
}

