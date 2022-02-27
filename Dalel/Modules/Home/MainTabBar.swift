//
//  ViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class MainTabBar: UITabBarController {

    @IBOutlet weak var mainBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
        mainBar.items![0].title = "home".localizede
        mainBar.items![1].title = "Favorites".localizede
        mainBar.items![2].title = "Notifications".localizede
        mainBar.items![3].title = "Profile".localizede
    }


}


