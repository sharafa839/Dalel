//
//  SchoolsViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class SchoolsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subCategorycollectionView: UICollectionView!
    var centerId:String?
    let homeViewModel = HomeViewModel()
    init(centerId:String) {
        self.centerId = centerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 
