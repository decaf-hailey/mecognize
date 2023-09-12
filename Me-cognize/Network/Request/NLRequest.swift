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

class NLRequest {
    static func performRequest<T: Codable>(_ router: APIsRouter, decoder: JSONDecoder = JSONDecoder(), success: @escaping SuccessHandler<T>, failure: @escaping ErrorHandler) {
//        AF.request(router, interceptor: router.interceptor)
        AF.request(router)
            .responseDecodable(queue: .main, decoder: decoder) { (response: DataResponse<T, AFError>) in
                SerializeData(response: response, type: T.self) { data in
                    Util.Print.PrintLight(printType: .response(router: router.path, data))
                    success(data)
                } failure: { error in
                    Util.Print.PrintLight(printType: .responseError(router: router.path, error))
                    failure(error)
                }
            }
    }
    
    static func analyzeSentiment(document: Document, success: @escaping SuccessHandler<ResponseSentiment>, failure: @escaping ErrorHandler){
        performRequest(.analyzeSentiment(document), success: success, failure: failure)
    }
}
