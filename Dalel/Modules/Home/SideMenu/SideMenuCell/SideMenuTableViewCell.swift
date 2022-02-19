//
//  SideMenuTableViewCell.swift
//  Dalel
//
//  Created by Shgardi on 18/02/2022.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(sideMenu:SideMenu){
        icon.image = sideMenu.image ?? UIImage()
        title.text = sideMenu.title ?? ""
    }
    
}
