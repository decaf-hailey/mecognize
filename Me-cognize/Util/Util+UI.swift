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
        static func getKeyRootView() -> UIViewController? {
//            if #available(iOS 13.0, *) {
                let key = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                return key?.rootViewController
//            } else {
//                return UIApplication.shared.keyWindow?.rootViewController
//            }
        }
        
        static func getKeyWindow(_ callback: @escaping (UIWindow?)->()) { //mainthread에서 실행할 것!
            DispatchQueue.main.async {
                let key = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                callback(key)
            }
        }
        
        static func presentFullOpacitySheet(_ nextView: UIViewController, completion: (() -> Void)? = nil){
            nextView.view.backgroundColor = .clear
            nextView.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//            nextView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            DispatchQueue.main.async {
                Util.UI.getKeyRootView()?.present(nextView, animated: false, completion: completion)
            }
        }
        
        static func presentFullScreen(_ nextView: UIViewController, completion: (() -> Void)? = nil) {
            nextView.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                Util.UI.getKeyRootView()?.present(nextView, animated: false, completion: completion)
            }
        }
        static func presentFullScreen(animated:Bool, _ nextView: UIViewController, completion: (() -> Void)? = nil) {
            nextView.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                Util.UI.getKeyRootView()?.present(nextView, animated: animated, completion: completion)
            }
        }
        static func pushScreen(_ nextView: UIViewController?, animated : Bool = true){
            guard let _nextView = nextView else {
                return
            }
            DispatchQueue.main.async {
                Util.UI.getKeyRootView()?.navigationController?.pushViewController(_nextView, animated: animated)
            }
        }
        static func getViewControllerInStotyBoard<T: UIViewController>(story:String, controller: T.Type) -> T {
            let storyboard = UIStoryboard.init(name: story, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: String(describing: T.reuseIdentifier)) as! T
        }
        
        static func makeKeyAndVisible(_ vc: UIViewController?, _ appdelegateWindow: UIWindow? = nil) {
            guard appdelegateWindow == nil else {
                appdelegateWindow?.rootViewController = vc
                appdelegateWindow?.makeKeyAndVisible()
                return
            }
        
            let key = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            key?.rootViewController = vc
            key?.makeKeyAndVisible()
        }
        
        static func hideKeyboard() {
            DispatchQueue.main.async {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}
