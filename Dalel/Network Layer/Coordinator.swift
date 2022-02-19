//
//  Coordinator.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import Foundation
import UIKit
class AppCoordinator {
    
    // MARK:- Properties
    
    private(set) var window: UIWindow
    
    var rootViewController: UIViewController? {
        window.rootViewController
    }
    
    var presentedViewController: UIViewController? {
        rootViewController?.presentedViewController
    }
    
    var topMostController: UIViewController? {
        rootViewController?.view.topMostController()
    }
    
    // MARK:- init
    
    init(_ window: UIWindow? = nil) {
        self.window = window ?? UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK:- Methods
    
    func setRoot(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
  
    
    func presentOnRoot(_ viewController: UIViewController) {
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
class AppUtilities {
    static func changeRoot(root:UIViewController, animated:Bool = true, completion: (() -> Void)? = nil )  {
        let coordinator = (UIApplication.shared.delegate as! AppDelegate).coordinator
        guard animated else {
            coordinator.setRoot(root)
            return
        }
        
        UIView.transition(with: coordinator.window, duration: 0.7, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            coordinator.setRoot(root)
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            if (completion != nil) {
                completion!()
            }
        })
    }
}
