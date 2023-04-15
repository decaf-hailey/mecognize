//
//  ViewController.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/25.
//

import UIKit
import AppAuth
import GoogleSignIn

//Recognize myself and understand why I behave this way towards others.

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func signIn(sender: Any) {
        let issuer = URL(string: "https://accounts.google.com")
        let redirectURI = URL(string: AppCredential.shared.redirectURI)
        guard let _issuer = issuer, let _redirectURI = redirectURI else {
            return
        }
        OIDAuthorizationService.discoverConfiguration(forIssuer: _issuer) { configuration, error in
            let request = OIDAuthorizationRequest(configuration: configuration!,
                                                  clientId: AppCredential.shared.clientId,
                                                  scopes: [OIDScopeOpenID, OIDScopeProfile,
                                                           "https://www.googleapis.com/auth/cloud-platform",
                                                           "https://www.googleapis.com/auth/cloud-language"],
                                                  redirectURL: _redirectURI,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in
                print("Got authorization tokens. Access token: \(authState?.lastTokenResponse?.accessToken ?? "DEFAULT_TOKEN")")
                guard let accessToken = authState?.lastTokenResponse?.accessToken,
                      let refreshToken = authState?.lastTokenResponse?.refreshToken else {
                    return
                }
                
                AppCredential.shared.set(accessToken, refreshToken: refreshToken)
            }
        }
    }
    
    
    @IBAction func submit(_ sender: Any) {
        let data = Document(content: "", language: "en", type: DocumentType.PLAIN_TEXT.rawValue)
        NLRequest.analyzeSentiment(document: data) { response in
            print("-------------response ",response)
        } failure: { error in
            print("-------------error",error)
        }
        
    }
    
    
    
}

