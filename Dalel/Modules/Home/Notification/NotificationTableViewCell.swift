//
//  NotificationTableViewCell.swift
//  Dalel
//
//  Created by Shgardi on 25/02/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.layer.cornerRadius = customView.frame.height / 2
            customView.clipsToBounds = true
        }
    }
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(model : NotificationModelPayload){
     
        notificationLabel.text = model.data?.subject
        timeLabel.text = DateAndTimeInString(date: model.createdAt ?? "", local: "en_US").0
    }
}
