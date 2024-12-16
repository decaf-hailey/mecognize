//
//  AppDelegate.swift
//  Me-cognize
//
//  Created by Hailey on 2023/02/25.
//

import UIKit
import CoreData
import GoogleSignIn
import AppAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var currentAuthorizationFlow: OIDExternalUserAgentSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let _ = error {
                // error alert for future                
                // Util.UI.getKeyRootView()?.showAlert(error.localizedDescription)
            } else {
                if let user = user {
                    Util.Print.PrintLight(printType: .checkValue("google login  accessToken = \(user.accessToken.tokenString) \n refresh token = \(user.refreshToken.tokenString)"))
                    AppCredential.shared.set(user.accessToken.tokenString, refreshToken: user.refreshToken.tokenString)
                } else {
                    // Show the app's signed-out state.
                      Util.UI.getKeyRootView()?.showAlert("Show the app's signed-out state.")
                }
            }
        }
        
        return true
    }

    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

        if let authorizationFlow = self.currentAuthorizationFlow, authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            self.currentAuthorizationFlow = nil
            return true
        }

      return false
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Me_cognize")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

