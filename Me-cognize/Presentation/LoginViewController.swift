//
//  ViewController.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/25.
//

import UIKit
import AppAuth
import GoogleSignIn

//Recognize myself and understand my behave towards others.
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
        OIDAuthorizationService.discoverConfiguration(forIssuer: _issuer) { [weak self] configuration, error in
            guard let self = self else { return }
            
            if let authError = error  {
                Util.Print.PrintLight(printType: .responseError(authError))
                self.showAlert(authError.localizedDescription)
                return
            }
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
                Util.Print.PrintLight(printType: .response("Got authorization tokens. Access token: \(authState?.lastTokenResponse?.accessToken ?? "DEFAULT_TOKEN")"))
                
                guard let accessToken = authState?.lastTokenResponse?.accessToken,
                      let refreshToken = authState?.lastTokenResponse?.refreshToken else {
                    return
                }
                
                self.presentHisotyVc()
                
                AppCredential.shared.set(accessToken, refreshToken: refreshToken)
            }
        }
    }
    
    func presentHisotyVc(){
        let historyVc = Util.UI.getViewControllerInStotyBoard(story: "Main", controller: HistoryViewController.self)
        Util.UI.makeKeyAndVisible(UINavigationController(rootViewController: historyVc))
    }
    
    @IBAction func submit(_ sender: Any) {
        // todo: test code 지우기
        let token = "ya29.a0AfB_byBHxmLE3UyWbMT6emxrPi4dWH39JzTqfF6jdIP-7BCsI6dmiwqOdXMptcR0gd2GDnoEtfl1ng8cN0RECG4da0j9YrYIeJ9BbJdk4K1zjFtSKVNJ4jHMEY1YPadXkCdaPompmszCTQDGqkQx5ZVrURkGaCgYKAbcSARISFQHsvYlsqvK4RHHf4zcTGOZKi5689A0163"
        
        AppCredential.shared.set(token, refreshToken: token)
        
        presentHisotyVc()
        
        
        //        let data = Document(content: "", language: "en", type: DocumentType.PLAIN_TEXT.rawValue)
        //        NLRequest.analyzeSentiment(document: data) { response in
        //            Util.Print.PrintLight(printType: .checkValue(response))
        //        } failure: { error in
        //            Util.Print.PrintLight(printType: .responseError(error))
        //        }
        
    }
    
    
    
}

