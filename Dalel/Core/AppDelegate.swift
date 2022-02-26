//
//  AppDelegate.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate, LocalizationManagerDelegate{
    

    var window: UIWindow?
    let locationManager = CLLocationManager()
    static let shared = AppDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        Router.setLaunch(window: window)
        GMSServices.provideAPIKey("AIzaSyD1fbW1OdbVEOd-vnP3VcaTeaooVrjmsSs")
        LocalizationManager.shared.setAppInnitLanguage()
        LocalizationManager.shared.delegate = self
        return true
    }



    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled()  {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
         
        }}
    
    func resetApp() {
        guard let window = window  else {return}
        print("local")
        if HelperK.checkFirstTime() == true{
            
            if HelperK.checkUserToken() == true{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main")
        window.rootViewController = vc
        let option : UIView.AnimationOptions = .transitionCrossDissolve
        let duration : TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: option, animations: nil, completion: nil)
                
                }else{
                    let login = LoginViewController()
                    let rootVc = UINavigationController(rootViewController: login)
                    window.rootViewController = rootVc
                    let option : UIView.AnimationOptions = .transitionCrossDissolve
                    let duration : TimeInterval = 0.3
                            UIView.transition(with: window, duration: duration, options: option, animations: nil, completion: nil)
                }}else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
let onBoarding = OnBoardingViewController()
                    let rootViewController = UINavigationController(rootViewController: onBoarding)
                    window.rootViewController = rootViewController
                let option : UIView.AnimationOptions = .transitionCrossDissolve
                let duration : TimeInterval = 0.3
                        UIView.transition(with: window, duration: duration, options: option, animations: nil, completion: nil)
            }
        
    }
    
    
}

extension UIApplication {

     class func getTopViewController(base: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
       if let data = text.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               return json
           } catch {
               print("Something went wrong")
           }
       }
       return nil
    }
}
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

