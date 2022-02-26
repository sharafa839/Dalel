//
//  PlacesTableViewCell.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var edit: UIButton!{
        didSet{
            edit.setTitle("edit", for: .normal)
        }
    }
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageCenter: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.floatView(raduis: 15, color:UIColor(named: "MainColor") ?? UIColor())
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(place:PlacesModelPayload){
        if LocalizationManager.shared.getLanguage() == .Arabic {
            nameLabel.text = place.arName

        }else{
            nameLabel.text = place.enName

        }
        
        phone.text = place.phone ?? ""
        location.text = place.address ?? ""
        guard let image = place.mainMediaURL else{return}
        imageCenter.downlodImage(str: image)
    }
    
}
