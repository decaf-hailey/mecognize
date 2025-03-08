//
//  APIsPerform.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation
import Alamofire

typealias SuccessHandler<T> = ((T)->())
typealias ErrorHandler = (MeError)->()
typealias FetchResult<T: Codable> = (Result<T, MeError>)


class NLRequest {
    
    static func fetchData<T: Codable>(_ router: APIsRouter) async -> FetchResult<T> {
        let response = await AF.request(router).serializingData().response
        Util.Print.PrintLight(printType: .response(router: router.path, response.data))
        return checkStatusCode(from: response)
    }
    
    static func analyzeSentiment(document: Document) async -> FetchResult<ResponseSentiment>{
       return await fetchData(.analyzeSentiment(document))
    }
                  
}
