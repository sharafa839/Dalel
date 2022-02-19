//
//  WorkTimeTableViewCell.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import UIKit

class WorkTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(time:WorkTime){
        from.text = time.openTime
        to.text = time.closeTime
        if LocalizationManager.shared.getLanguage() == .Arabic {
            day.text = time.arDayName
           
        }else{
            day.text = time.enDayName

        }
    }
    
}
