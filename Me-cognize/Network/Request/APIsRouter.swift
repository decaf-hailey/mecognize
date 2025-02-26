//
//  APIsRouter.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation
import Alamofire


enum APIsRouter: URLRequestConvertible, NLRestApis {

    case analyzeSentiment(_ document: Document)
    
    // MARK: - HTTPMethod
    internal var method: HTTPMethod {
        .post
    }

    
    internal var path: String {
        Util.Network.Request.encodeUrl(urlString:  "/v1/documents:analyzeSentiment", urlParam: urlParameter)
       
    }
    
    var urlParameter: Parameters? {
        return ["key": AppCredential.shared.apiKey]
    }
    
    var bodyParameter: Encodable? {
        switch self {
        case .analyzeSentiment(let document):
//            return ["document": document, "encodingType": EncodingType.UTF16.rawValue]
            return RequestAnalyze(document: document, encodingType: EncodingType.UTF16)
            
        }
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
       try self.makeRequest()
    }
}
