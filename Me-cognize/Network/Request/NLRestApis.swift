//
//  NLRestApis.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation
import Alamofire

//Common

protocol NLRestApis {
    var method: HTTPMethod { get }
    var path: String { get }
    var bodyParameter: Encodable? { get }
//    var interceptor: RequestInterceptor { get }
}

extension NLRestApis {
    private var baseURL : String {
        Server.endpoint
    }
    
//    var interceptor : RequestInterceptor {
//        let credential = RaceAuthenticationCredential(accessToken:  refreshToken: )
//        let myInterceptor = AuthenticationInterceptor(authenticator: RaceAuthenticator(), credential: credential)
//        let interceptors = Interceptor(adapters: [], retriers: [], interceptors: [RaceRetryInterceptor(), myInterceptor])
//        let interceptors = Interceptor(adapters: [], retriers: [], interceptors: [])
//        return interceptors
//    }
    
    func makeRequest() throws -> URLRequest {
        guard let _url = URL(string: baseURL+path) else {
            Util.Print.PrintLight(printType: .systemError("URL이 잘못되었습니다. \(path)"))
            throw MeError.custom(reason: "url이 잘못되었음")
        }
        
        guard let token = AppCredential.shared.accessToken else {
            throw MeError.custom(reason: "토큰이 필요함")
        }
        var urlRequest = URLRequest(url: _url)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers.add(.authorization(bearerToken: token))
        urlRequest.headers.add(.contentType(ContentType.json.rawValue))
        
    
        if let _body = bodyParameter {
            do {
                urlRequest.httpBody = try Util.Network.Request.encodeBody(bodyParam: _body.toDictionary())
//                let en = URLEncodedFormParameterEncoder.default.encode(_body, into: urlRequest)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
    
        return urlRequest
    }
}


