//
//  FavoriteCollectionViewCell.swift
//  Dalel
//
//  Created by  on 21/02/2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var conatinerView: UIView!{
        didSet{
            conatinerView.floating(raduis: 15)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var deleteBButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(favorite:FavoriteModelPayload){
        if LocalizationManager.shared.getLanguage() == .Arabic{
            titleLabel.text = favorite.arName
        }else{
            titleLabel.text = favorite.enName

        }
        guard let image = favorite.mainMediaURL else {return}
    cellImage.downlodImage(str:"https://Dalil-taelim.com"+image)
    }
}
