//
//  LoginViewController.swift
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

//Recognize myself and understand my behave towards others.

protocol LoginDisplayLogic {
    func showHistoryView()
    func displayError(_ message: String)
}

class LoginViewController: UIViewController, LoginDisplayLogic {

    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBAction func signIn(sender: Any) {
        requestLogin()
    }
    
    func requestLogin() {
        let request = Login.Token.Request()
        interactor?.requestGoogleToken(request: request, viewController: self)
    }
    
    @IBAction func forTest(_ sender: Any) {
        let request = Login.Token.Local()
        interactor?.requestLocalToken(request: request)
    }
    
    func showHistoryView() {
        router?.routeToHistory()
    }
    
    func displayError(_ message: String) {
        self.showAlert(message)
    }
    
}

// MARK: - setup
extension LoginViewController {
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
