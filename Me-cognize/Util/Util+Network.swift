//
//  Util+Network.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/26.
//

import Foundation
import Alamofire

extension Util {
    enum Network{
        struct Request {
            //바디 파라미터
            static func encodeBody(bodyParam: Parameters? = nil) throws -> Data? {
                var bodyData: Data? = nil
                if let _body = bodyParam {
                    if let data = try? JSONSerialization.data(withJSONObject: _body, options: []) {
                        bodyData = data
                    } else {
                        Util.Print.PrintLight(printType: .SystemError(" URL: \(String(describing: bodyParam)) == encodeBody JSONSerialization 에러 == "))
                        throw MeError.jsonParsingError
                    }
                }
                
                return bodyData
            }
            
            static func encodeUrl(urlString: String,
                                  urlParam: Parameters? = nil) -> String {
                
                var _urlString = urlString.encodeUrl()
                
                //1.URL 파라미터
                if let _urlParam = urlParam {
                    _urlString += _urlParam.queryParameters
                }
                
                return _urlString
            }
            static func jsonString<T:Codable>(data: T) -> String? {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                do {
                    let myData = try encoder.encode(data)
                    let result = String(data: myData, encoding: .utf8)
                    return result
                } catch (let error) {
                    Util.Print.PrintLight(printType: .SystemError(error))
                    return nil
                }
            }
            static func jsonData<T:Codable>(data: T) -> Data? {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                do {
                    let result = try encoder.encode(data)
                    return result
                } catch (let error) {
                    Util.Print.PrintLight(printType: .SystemError(error))
                    return nil
                }
            }
        }
    }
}
