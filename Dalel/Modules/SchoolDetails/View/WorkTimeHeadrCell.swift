//
//  WorkTimeHeadrCell.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import UIKit

class WorkTimeHeadrCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!{
        didSet{
            dayLabel.text  = "day"
        }
    }
    @IBOutlet weak var fromLabel: UILabel!{
        didSet{
            fromLabel.text = "from"
        }
    }
    @IBOutlet weak var toLabel: UILabel!{
        didSet{
            toLabel.text = "to"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.floatView(raduis: 10, color: .clear)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
