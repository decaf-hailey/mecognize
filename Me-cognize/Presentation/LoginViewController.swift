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
                Util.Print.PrintLight(printType: .responseError("appDelegate == null"))
                return
            }
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { [weak self] authState, error in
                guard let self = self else { return }

                guard let accessToken = authState?.lastTokenResponse?.accessToken,
                      let refreshToken = authState?.lastTokenResponse?.refreshToken else {
                    Util.Print.PrintLight(printType: .responseError(error?.localizedDescription))
                    self.showAlert(error?.localizedDescription ?? "no token")
                    return
                }
                
                Util.Print.PrintLight(printType: .response("Got authorization tokens. Access token: \(accessToken)"))
                AppCredential.shared.set(accessToken, refreshToken: refreshToken)
                //Save tokens on Local for test due to frequent builds.
                LocalData.saveTokensForTest(accessToken: accessToken, refreshToken: refreshToken)
                self.presentHisotyVc()
                
            }
        }
    }
    
    func presentHisotyVc(){
        let historyVc = Util.UI.getViewControllerInStotyBoard(story: "Main", controller: HistoryViewController.self)
        Util.UI.makeKeyAndVisible(UINavigationController(rootViewController: historyVc))
    }
    
    @IBAction func forTest(_ sender: Any) {

        let tokens = LocalData.getTokensForTest()
        AppCredential.shared.set(tokens.accessToken, refreshToken: tokens.refreshToken)
        presentHisotyVc()
    }
    
    
    
}

