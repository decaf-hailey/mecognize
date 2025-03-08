//
//  SerializeData.swift
//  Me-cognize
//
//  Created by Hailey on 2023/03/05.
//

import Foundation
import Alamofire


// When you want to separate errors up to Status code
func checkStatusCode<T: Codable>(from dataResponse: DataResponse<Data, AFError>) -> FetchResult<T> {
    guard let response = dataResponse.response else {
        return .failure(MeError.disconnected)
    }
    let statusCode = response.statusCode
    switch statusCode {
        //MARK: - 401 re-login
    case 401:
        return .failure(.authError(errorCode: statusCode))
        //MARK: - 500 error message from server
    case 500:
        return .failure(.httpError(errorCode: statusCode, reason: "서버에러"))
        //MARK: - 502 tomcat error
    case 502:
        return .failure(.httpError(errorCode: statusCode, reason: "Bad Gateway"))
        //MARK: - request error
    case 400, 402...499:
        return .failure(.httpError(errorCode: statusCode, reason: "Please capture this and email it to us \n hailey_h_h@naver.com"))
        //MARK: - 204: no response value
    case 204:
        return .failure(.resultNil(errorCode: statusCode))
        
    case 200:
        return serialize(from: dataResponse.data)
        
    default:
        return .failure(.httpError(errorCode: statusCode, reason: ""))
    }
}

fileprivate func serialize<T: Codable>(from data: Data?) -> FetchResult<T> {
    guard let _data = data,
          let resultData = String(data: _data, encoding: .utf8), resultData.count > 0 else {
        return .failure(.resultNil(errorCode: 200))
    }
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: _data) as T
        return .success(decodedData)
    } catch is DecodingError {
        return .failure(.jsonParsingError(reason: ""))
    } catch let err as NSError {
        return .failure(.resultError(errorCode: 200, reason: err.debugDescription))
    }
}

