//
//  CategoriesCollectionViewCell.swift
//  Dalel
//
//  Created by Shgardi on 12/02/2022.
//

import UIKit


class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.drawBorder(raduis: 30, borderColor: UIColor(red: 86, green: 200, blue: 32, alpha: 0.35))
        viewContainer.floatView(raduis: 30, color:UIColor(named: "MainColor")  ?? UIColor())
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

