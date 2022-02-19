//
//  SideMenuViewModel.swift
//  Dalel
//
//  Created by Shgardi on 18/02/2022.
//

import Foundation
import UIKit

struct SideMenu {
    var image:UIImage?
    var title:String?
    
}

class SideMuneViewModel {
    let sidesMenu : [SideMenu] = [SideMenu(image: UIImage(named: "ic_outline-sticky-note-2"), title: "Home"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-1"), title: "language"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-2"), title: "addPlave"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-3"), title: "places"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-4"), title: "callUS"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-5"), title: "OurVision"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-5"), title: "OurGoals"),SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-6"), title: "Terms"),
    SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-7"), title: "Social"),
    SideMenu(image: UIImage(named: "ic_outline-sticky-note-2-7"), title: "signOut")]
    
}
