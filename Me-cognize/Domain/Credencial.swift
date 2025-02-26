//
//  Credencial.swift
//  Me-cognize
//
//  Created by Hailey on 2023/03/18.
//

import Foundation


struct Credential : Codable {
    let clientId: String
    let apiKey: String
    var redirectURI: String
}


class AppCredential {
    static let shared = AppCredential()
    
    let clientId: String
    let apiKey: String
    var redirectURI: String

    var accessToken: String?
    var refreshToken: String?

    internal init(){
        let getCredencial = Util.fromMock(dataType: Credential.self, forResource: "key")!
        self.clientId = getCredencial.clientId
        self.apiKey = getCredencial.apiKey
        self.redirectURI = getCredencial.redirectURI
    }
    
    func set(_ accessToken: String?, refreshToken: String?){
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}


