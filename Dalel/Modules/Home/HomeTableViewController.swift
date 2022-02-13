//
//  HomeTableViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class HomeTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var rodaCollectionView: UICollectionView!
    @IBOutlet weak var schoolsCollectionView: UICollectionView!
    @IBOutlet weak var universityCollectionView: UICollectionView!
    @IBOutlet weak var newUniversityLabel: UILabel!
    @IBOutlet weak var showMoreUniversityButton: UIButton!
    @IBOutlet weak var newSchoolsLabel: UILabel!
    @IBOutlet weak var showMoreSchools: UIButton!
    @IBOutlet weak var yourChanceLabel: UILabel!
    @IBOutlet weak var toAddYourCenterLabel: UILabel!
    @IBOutlet weak var addYourCenterButton: UIButton!
    @IBOutlet weak var childGardenLabel: UILabel!
    @IBOutlet weak var showMoreChildGardenButton: UIButton!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    
        
    
    var viewModel = HomeViewModel()
    var categories = [[String:String?]]()
    var universities = [CenterModelPayload]()
    var schools = [CenterModelPayload]()
    var childGarden = [CenterModelPayload]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupUI()
        attachViewMode()
        setupViewModel()
       
    }
    

    
    
    //MARK: -  methods
    func attachViewMode(){
        viewModel.getCategory()
        
    }
    
    func setupUI(){
        CategoryCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        
    }
    
    func setupViewModel(){
        viewModel.onError.subscribe {  error in
            
            HelperK.showError(title: error.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)


    }
    
    func setupObservers(){
        viewModel.onSuccess.subscribe {[weak self] category in
            guard let self = self else {return}
            guard let category = category.element else {return}
            self.categories.append(contentsOf: category)
        }.disposed(by: viewModel.disposeBag)
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1 :
            return categories.count
        default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            let category = categories[indexPath.row] 
            cell.configure(payload: categories[indexPath.row])
            return cell
        default : return UICollectionViewCell()
        }

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
