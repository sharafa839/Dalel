//
//  HomeTableViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit
import  ImageSlideshow
import SideMenu
class HomeTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var rodaCollectionView: UICollectionView!
    @IBOutlet weak var schoolsCollectionView: UICollectionView!
    @IBOutlet weak var universityCollectionView: UICollectionView!
    @IBOutlet weak var newUniversityLabel: UILabel!{
        didSet{
        newUniversityLabel.text = "New university".localizede
    }
    }
    @IBOutlet weak var showMoreUniversityButton: UIButton!{
        didSet{
            showMoreUniversityButton.setTitle("Show more".localizede, for: .normal)
        }
    }
    @IBOutlet weak var newSchoolsLabel: UILabel!{
        didSet{
            newSchoolsLabel.text = "New School".localizede
        }
    }
    @IBOutlet weak var showMoreSchools: UIButton!{
        didSet{
            showMoreSchools.setTitle("Show more".localizede, for: .normal)
        }
    }
    @IBOutlet weak var yourChanceLabel: UILabel!{
        didSet{
            yourChanceLabel.text = "get your chance".localizede
        }
    }
    @IBOutlet weak var toAddYourCenterLabel: UILabel!{
        didSet{
                toAddYourCenterLabel.text = "to add your center".localizede
            }
        }
    
    @IBOutlet weak var addYourCenterButton: UIButton!{
        didSet{
            addYourCenterButton.setTitle("Add your center".localizede, for: .normal)
            addYourCenterButton.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var childGardenLabel: UILabel!{
        didSet{
            childGardenLabel.text = "Child garden".localizede
        }
    }
    @IBOutlet weak var showMoreChildGardenButton: UIButton!{
        didSet{
            showMoreChildGardenButton.setTitle("Show more".localizede, for: .normal)
        }
    }
    @IBOutlet weak var categoriesLabel: UILabel!{
        didSet{
            categoriesLabel.text = "categories".localizede
        }
    }
    @IBOutlet weak var searchButton: UIButton!{
        didSet{
            searchButton.setTitle("search".localizede, for: .normal)
            searchButton.floatView(raduis: 10, color: .black)
            
        }
    }
    @IBOutlet weak var containViewOfImage: UIView!{
        didSet{
            containViewOfImage.floatView(raduis: 15, color: .clear)
        }
    }
    @IBOutlet weak var imageSlider: ImageSlideshow!{
        didSet{
            self.imageSlider.configSliderShow()
            self.imageSlider.setRoundCorners(15)
            self.imageSlider.addActionn(vc: self, action: #selector(didTab))
        }
    }
    
        
    
    var viewModel = HomeViewModel()
    var categories = [CategoriesModelPayload]()
    var universities = [CagtegoryCenterModelPayload]()
    var schools = [CagtegoryCenterModelPayload]()
    var childGarden = [CagtegoryCenterModelPayload]()
    var imageSourc = [InputSource]()
var allCenters  = [CenterModelPayload]()
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        setupUI()
        attachViewMode()
        setupViewModel()
        setupObservers()
        setupObserversUI()
        signOut()
        navigationController?.navigationBar.isHidden = true
    }

    

    
    
    //MARK: -  methods
    func attachViewMode(){
        viewModel.getCategory()
        viewModel.getBanners()
        viewModel.getSchools(id: nil)
        viewModel.getUniversity(id: nil)
        viewModel.getKidsGarden(id: nil)
    }
    
    @objc func didTab()  {
        imageSlider.presentFullScreenController(from: self)
    }
    
    func setupUI(){
        CategoryCollectionView.register(CategoriesCollectionViewCell.nib,
                                forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        rodaCollectionView.register(CategoriesCollectionViewCell.nib,
                                forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        schoolsCollectionView.register(CategoriesCollectionViewCell.nib,
                                forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        universityCollectionView.register(CategoriesCollectionViewCell.nib,
                                forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        CategoryCollectionView.register(CategoriesCollectionViewCell.nib,
                                forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        tableView.contentInset.top = 0
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
    
    func setupObserversUI(){
        searchButton.rx.tap.subscribe {[weak self] _ in
            let searchVc = SearchViewController()
            self?.navigationController?.pushViewController(searchVc, animated: true)
        }.disposed(by: viewModel.disposeBag)

        showMoreSchools.rx.tap.subscribe {[weak self] _ in
            let categoryViewController = SchoolsViewController(centerId: "cce5da55-9651-463c-b0cc-84280fc5a53f", title: "schools".localizede)
            
            self?.navigationController?.pushViewController(categoryViewController, animated: true)
        }.disposed(by: viewModel.disposeBag)
        showMoreChildGardenButton.rx.tap.subscribe { [weak self] _ in
            let categoryViewController = SchoolsViewController(centerId: "353c2229-17c7-4f01-bd16-dabcdc6473b3", title: "ChildGargen".localizede)
            
            self?.navigationController?.pushViewController(categoryViewController, animated: true)
        }.disposed(by: viewModel.disposeBag)
        showMoreUniversityButton.rx.tap.subscribe { [weak self] _ in
            let categoryViewController = SchoolsViewController(centerId: "71f65e07-e816-4296-9dd5-8c48e3d785ea", title: "University".localizede)
            
            self?.navigationController?.pushViewController(categoryViewController, animated: true)
        }.disposed(by: viewModel.disposeBag)

        
        
        

    }
  
    @IBAction func addYourCenterButton(_ sender: UIButton) {
        let vc = AddPlaceViewController()
        present(vc, animated: true, completion: nil)
    }
    
    func setupObservers(){
        viewModel.onSuccess.subscribe {[weak self] category in
            guard let self = self else {return}
            guard let category = category.element else {return}
            self.categories.append(contentsOf: category)
            self.CategoryCollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        viewModel.banners.subscribe { banners in
            guard let banner = banners.element else {return}
            self.imageSourc.removeAll()
            for i in banner{
                let urlStr = "https://Dalil-taelim.com" + ((i.mainMediaURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
                print(urlStr)
                ActivityIndicatorManager.shared.hideProgressView()
                self.imageSourc.append(KingfisherSource(urlString: urlStr)!)
                DispatchQueue.main.async {
                    self.imageSlider.setImageInputs(self.imageSourc)
                }
            }

        }.disposed(by: viewModel.disposeBag)
        viewModel.schoolResponse.subscribe {[weak self] school in
            guard let self = self else {return}
            guard let schools = school.element else {return}
            self.schools.append(contentsOf: schools ?? [CagtegoryCenterModelPayload]())
            self.schoolsCollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        viewModel.universityResponse.subscribe { [weak self]univsity in
            guard let self = self else {return}
            guard let univsities = univsity.element else {return}
            self.universities.append(contentsOf: univsities ?? [CagtegoryCenterModelPayload]())
            self.universityCollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        viewModel.kidsGardenResponse.subscribe {[weak self] garden in
            guard let self = self else {return}
            guard let gardens = garden.element else {return}
            self.childGarden.append(contentsOf: gardens ?? [CagtegoryCenterModelPayload]())
            self.rodaCollectionView.reloadData()
        
        }.disposed(by: viewModel.disposeBag)

    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0 :
            return 80
        case 1:
            return 200
        case 2:
            return 280
        case 3 :
            return 280
        case 4 :
            return 280
        case 5:
            return 280
        case 6:
            return 280
            
        default:
            return 280
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return categories.count
        }else if collectionView.tag == 2 {
            return childGarden.count
        }else if collectionView.tag == 3{
            return schools.count
        }else if collectionView.tag == 4 {
            return universities.count
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell

        if collectionView.tag == 1 {
            
            let category = categories[indexPath.row]
            cell.configure(payload: category)
            return cell
        }else if collectionView.tag == 2{
            let gardens = childGarden[indexPath.row]
            cell.configureCell(payload: gardens)
            return cell

        }else if collectionView.tag == 3{
            let schools = schools[indexPath.row]
            cell.configureCell(payload: schools)
            return cell

        }else if collectionView.tag == 4{
            let universites = universities[indexPath.row]
            cell.configureCell(payload: universites)
            return cell
        }else{
         return UICollectionViewCell()

        }

    }
    
    func signOut(){
        let sideMenue = SideMenueViewController()
        
        sideMenue.didSignOut = { [weak self] in
            let login = LoginViewController()
let nav = UINavigationController(rootViewController: login)
            self?.present(nav, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func sideMenue(_ sender: UIButton) {
        let side = storyboard?.instantiateViewController(withIdentifier: "nav")

present(side!, animated: true, completion: nil)
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: 120 , height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1 :
            guard let categoryId = categories[indexPath.row].id else {return}
            if LocalizationManager.shared.getLanguage() == .Arabic{
                guard let title = categories[indexPath.row].arName else {return}
                        let centerViewController  =  SchoolsViewController(centerId: categoryId,title: title)
                        navigationController?.pushViewController(centerViewController, animated: true)
            }else{
                guard let title = categories[indexPath.row].enName else {return}
                        let centerViewController  =  SchoolsViewController(centerId: categoryId,title: title)
                        navigationController?.pushViewController(centerViewController, animated: true)
            }
            
           
        case 2 :
            guard let centerId = childGarden[indexPath.row].id else {return}
            let centerViewController  =  SchoolDetailsViewController(centerId: centerId)
            navigationController?.pushViewController(centerViewController, animated: true)
        case 3:
            guard let centerId =  schools[indexPath.row].id else {return}
            let centerViewController  =  SchoolDetailsViewController(centerId: centerId)
            navigationController?.pushViewController(centerViewController, animated: true)

        case 4:
            guard let centerId = universities[indexPath.row].id else {return}
            let centerViewController  =  SchoolDetailsViewController(centerId: centerId)
            navigationController?.pushViewController(centerViewController, animated: true)

        default :
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
