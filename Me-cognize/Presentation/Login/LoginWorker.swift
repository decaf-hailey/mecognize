//
//  LoginWorker.swift
//  Me-cognize
//
//  Created by Hailey on 2023/08/29.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import AppAuth
import GoogleSignIn

class LoginWorker {
    
    func getGoogleToken(request: Login.Token.Request, viewController: LoginViewController, suceess: @escaping ()->(), failed: @escaping (String)->()){
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: request.issuer) { configuration, error in
            guard let configuration = configuration else { return }
            
            if let authError = error  {
                Util.Print.PrintLight(printType: .responseError(router: "OIDAuthorizationService.discoverConfiguration", authError))
                failed(authError.localizedDescription)
                return
            }
            let request = OIDAuthorizationRequest(configuration: configuration,
                                                  clientId: AppCredential.shared.clientId,
                                                  scopes: [OIDScopeOpenID, OIDScopeProfile,
                                                           "https://www.googleapis.com/auth/cloud-platform",
                                                           "https://www.googleapis.com/auth/cloud-language"],
                                                  redirectURL: request.redirectURI,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                Util.Print.PrintLight(printType: .systemError("appDelegate == null"))
                return
            }
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: viewController) { authState, error in
                
                guard let accessToken = authState?.lastTokenResponse?.accessToken,
                      let refreshToken = authState?.lastTokenResponse?.refreshToken else {
                    Util.Print.PrintLight(printType: .responseError(router: "appDelegate.currentAuthorizationFlow", error?.localizedDescription))
                    failed(error?.localizedDescription ?? "no token")
                    return
                }
                
                Util.Print.PrintLight(printType: .response(router: "Got authorization tokens. Access token: \(accessToken)", nil))
                AppCredential.shared.set(accessToken, refreshToken: refreshToken)
                //Save tokens locally for test builds.
                LocalData.saveTokensForTest(accessToken: accessToken, refreshToken: refreshToken)
                suceess()
            }
        }
    }
}
