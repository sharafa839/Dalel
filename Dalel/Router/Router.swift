//
//  Router.swift
//  Baladna
//
//  Created by Ahmed on 01/11/2021.
//

import Foundation
import UIKit
class Router {
    class func NavToRegister(window:UIWindow?) {
        guard  let window = window else {
            return
        }
        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let x =   UINavigationController(rootViewController: login)
        window.rootViewController = x
        window.makeKeyAndVisible()
    }
    
    class func setLaunch(window:UIWindow?){
        guard HelperK.checkUserToken() == true else {
            if HelperK.checkFirstTime() {
                setRoot(nibName: OnBoardingViewController.loadFromNib(), window: window)
            }else {
                setRoot(nibName: LoginViewController.loadFromNib(), window: window)
            }
            return
        }
        setRoot(nibName: MainTabBar(), window: window)
    }

    class func setRoot(nibName:UIViewController,window:UIWindow?){
        
        let navigationViewController = UINavigationController(rootViewController: nibName)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
