//
//  Util+UI.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/09.
//

import Foundation
import UIKit

extension Util {
    enum UI {
         
        @MainActor
        static func getKeyRootView() -> UIViewController? {
            let key = UIApplication.shared.connectedScenes
                .filter(
                    {$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive
                    })
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return key?.rootViewController
        }
        
        static func getKeyWindow() async -> UIWindow? {
            
            //mainthread에서 실행할 것!
            return await MainActor.run(resultType: UIWindow?.self) {
                let key = UIApplication.shared.connectedScenes
                    .filter(
                        {$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive
                        })
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                return key
            }
                    
        }
        
        static func presentFullOpacitySheet(
            _ nextView: UIViewController,
            completion: (() -> Void)? = nil
        ) {
            
            nextView.view.backgroundColor = .clear
            nextView.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            
            Task { @MainActor in
                Util.UI
                    .getKeyRootView()?
                    .present(nextView, animated: false, completion: completion)
            }
            
        }
        
        static func presentFullScreen(
            _ nextView: UIViewController,
            completion: (() -> Void)? = nil
        ) {
            nextView.modalPresentationStyle = .fullScreen
            Task { @MainActor in
                Util.UI
                    .getKeyRootView()?
                    .present(nextView, animated: false, completion: completion)
            }
        }
        static func presentFullScreen(
            animated:Bool,
            _ nextView: UIViewController,
            completion: (() -> Void)? = nil
        ) {
            nextView.modalPresentationStyle = .fullScreen
            Task { @MainActor in
                Util.UI
                    .getKeyRootView()?
                    .present(nextView, animated: false, completion: completion)
            }
        }
        static func pushScreen(
            _ nextView: UIViewController?,
            animated : Bool = true
        ){
            guard let _nextView = nextView else {
                return
            }
            
            Task { @MainActor in
                Util.UI
                    .getKeyRootView()?.navigationController?
                    .pushViewController(_nextView, animated: animated)
            }
        }
        static func getViewControllerInStotyBoard<T: UIViewController>(story:String, controller: T.Type) -> T {
            let storyboard = UIStoryboard.init(name: story, bundle: nil)
            return storyboard
                .instantiateViewController(
                    withIdentifier: String(describing: T.reuseIdentifier)
                ) as! T
        }
        
        static func getNavigationControllerInStotyBoard(story:String, id: String) -> UINavigationController {
            let storyboard = UIStoryboard.init(name: story, bundle: nil)
            return storyboard
                .instantiateViewController(
                    withIdentifier: id
                ) as! UINavigationController
        }
        
        static func makeKeyAndVisible(
            _ vc: UIViewController?,
            _ appdelegateWindow: UIWindow? = nil
        ) {
            if let scene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive
                }).map({$0 as? UIWindowScene}) {
                
                if let window = scene?.windows.first(
                    where: { $0.isKeyWindow
                    }) {
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                    return
                }
                
                Util.Print
                    .PrintLight(
                        printType: .systemError("fail to find key window")
                    )
            }
        }
        
        @MainActor
        static func hideKeyboard() {
                UIApplication.shared
                    .sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil, for: nil)
        }
    }
}
