//
//  AppDelegate.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
let register = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        window?.rootViewController = register
        window?.makeKeyAndVisible()
        
        return true
    }




}

