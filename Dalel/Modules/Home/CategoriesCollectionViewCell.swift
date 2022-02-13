//
//  CategoriesCollectionViewCell.swift
//  Dalel
//
//  Created by Shgardi on 12/02/2022.
//

import UIKit


class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(payload:[String:String?]){
        let payloads = payload["payload"] as? String  ?? ""
        let data = convertStringToDictionary(text: payloads)
        categoryName.text = data?["en_name"] as? String ?? ""
     
        categoryImage.downlodImage(str: data?["icon"] as? String ?? "")
        
    }

}
func convertStringToDictionary(text: String) -> [String:AnyObject]? {
   if let data = text.data(using: .utf8) {
       do {
           let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
           return json
       } catch {
           print("Something went wrong")
       }
   }
   return nil
}
