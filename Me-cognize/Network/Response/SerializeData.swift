//
//  SerializeData.swift
//  Me-cognize
//
//  Created by Hailey on 2023/03/05.
//

import Foundation
import Alamofire

func SerializeData<T:Codable>(response: DataResponse<T, AFError>, type: T.Type, success: @escaping SuccessHandler<T>, failure: @escaping ErrorHandler) {
    

    guard let statusCode = response.response?.statusCode else {
        
        let result = response.result
        switch result {
        case .success(_): break
        case .failure(_):
            DispatchQueue.main.async {
                failure(MeError.disconnected)
                //            HudView.shared.dismissHud()
            }
        }
        return
    }
    
    switch response.result {
    case .success(_):
        CommonResponse(statusCode: statusCode, data: response.data, type: type, success: { (data) in
            DispatchQueue.main.async {
                success(data)
                //            HudView.shared.dismissHud()
            }
        }, failure: { (error) in
            DispatchQueue.main.async {
                failure(error)
                //            HudView.shared.dismissHud()
            }
        })
    case .failure(let error):
        failure(.httpError(errorCode: statusCode, reason: error.localizedDescription))
    }
    
    
}

fileprivate func CommonResponse<T: Codable>(statusCode: Int, data: Data?, type: T.Type, success: @escaping SuccessHandler<T>, failure: @escaping ErrorHandler){
    switch statusCode {
        //MARK: - 401 재로그인 필요
    case 401:
        failure(MeError.authError(errorCode: statusCode))
        break
        //MARK: - 500 서버에서 내려오는 메세지 있음/없음
    case 500:
        
        failure(.httpError(errorCode: statusCode, reason: "서버에러"))
        //MARK: - 502 톰캣에러
    case 502:
        failure(MeError.httpError(errorCode: statusCode, reason: "Bad Gateway"))
        
        //MARK: - 요청오류
    case 400, 402...499:
        failure(MeError.httpError(errorCode: statusCode, reason: "요청 확인이 필요합니다. 고객센터에 문의해주세요."))
        
        //MARK: - 204: 결과값이 x없음
    case 204:
        failure(MeError.resultNil(errorCode: statusCode))
        
    case 200:
        // - 🥕 200: 결과값이 원래(!) x없음
        guard let _data = data,
              let resultData = String(data: _data, encoding: .utf8), resultData.count > 0 else {
            failure(MeError.resultNil(errorCode: statusCode))
            return
        }
        //- 200대: 결과값이 o있음 -> json 디코딩
        guard let serverData = try? JSONDecoder().decode(T.self, from: _data) as T else {
            do {
                let new = try JSONDecoder().decode(T.self, from: _data) as T
                success(new.self)
            }
            catch let err as NSError {
                failure(.jsonParsingError(reason: err.debugDescription))
            }
            return
        }
        success(serverData.self)
        
    default:
        if let _data = data {
            failure(.resultError(errorCode: statusCode, reason: String(data: _data, encoding: .utf8) ?? ""))
        } else {
            failure(.custom(reason: "(\(statusCode))"))
        }
    }
}


