//
//  CategoriesCollectionViewCell.swift
//  Dalel
//
//  Created by  on 12/02/2022.
//

import UIKit


class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!{
        didSet{
            viewContainer.floating(raduis: 15)
            viewContainer.layer.borderWidth = 0.4
        }
    }
    @IBOutlet weak var categoryImage: UIImageView!{
        didSet{
            categoryImage.roundSingleConrner(.bottomLeft, .layerMinXMinYCorner, radius: 20)
        }
    }
    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.floating(raduis: 15)
    }
    func configure(payload:CategoriesModelPayload){
        if LocalizationManager.shared.getLanguage() == .Arabic{
        categoryName.text = payload.arName
        }else{
            categoryName.text = payload.enName
        }
        guard let image = payload.icon else {return}
        categoryImage.downlodImage(str:"https://Dalil-taelim.com" + image)
        
    }
    
    func configureCell(payload:CagtegoryCenterModelPayload){
        if LocalizationManager.shared.getLanguage() == .Arabic{
        categoryName.text = payload.arName
        }else{
            categoryName.text = payload.enName
        }
        guard let image = payload.mediaLinks?.first?.link else {return}
        categoryImage.downlodImage(str:"https://Dalil-taelim.com" + image)
        
    }
    func configureCellSearch(payload:SearchModelPayload){
        if LocalizationManager.shared.getLanguage() == .Arabic{
        categoryName.text = payload.arName
        }else{
            categoryName.text = payload.enName
        }
        guard let image = payload.mediaLinks?.first?.link else {return}
        categoryImage.downlodImage(str:"https://Dalil-taelim.com" + image)
        
    }


}

