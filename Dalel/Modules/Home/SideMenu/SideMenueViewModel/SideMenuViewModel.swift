//
//  SideMenuViewModel.swift
//  Dalel
//
//  Created by  on 18/02/2022.
//

import Foundation
import UIKit

struct SideMenu {
    var image:UIImage?
    var title:String?
    
}

class SideMuneViewModel {
    let sidesMenu : [SideMenu] = [SideMenu(image: UIImage(named: "ic_outline-sticky-note-2"), title: "Home".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-1"), title: "language".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-2"), title: "addPlace".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-3"), title: "places".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-4"), title: "callUS".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-5"), title: "OurVision".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-5"), title: "OurGoals".localizede),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-6"), title: "Terms".localizede),
                                  SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-7"), title: "Social".localizede),
                                  SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-7"), title: "FAQS".localizede),
                                  SideMenu(image:UIImage(named:"ic_outline-sticky-note-2-7"), title: "Places on the map".localizede),
                                  SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-7"), title: "signOut".localizede)]
    
}
