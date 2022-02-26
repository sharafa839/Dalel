//
//  SchoolsViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class SchoolsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subCategorycollectionView: UICollectionView!
    var centerId:String?
    var titl :String?
    var centersInCategory = [CagtegoryCenterModelPayload]()
    let viewModel = SubHomeViewModel()
    init(centerId:String,title:String) {
        self.centerId = centerId
        self.titl = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        attach()
        setupCollectionView()
       subscribeViewModel()
        setupViewModel()
        setupUI()
    }
    
    func attach(){
        viewModel.getCategory(id: centerId ?? "")
    }

    func subscribeViewModel(){
        viewModel.categories.subscribe { [weak self] categories in
            guard let category = categories.element else {return}
            self?.centersInCategory.append(contentsOf:category)
            self?.subCategorycollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)

    }
    
    func setupCollectionView(){
        subCategorycollectionView.register(CategoriesCollectionViewCell.nib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        subCategorycollectionView.delegate = self
        subCategorycollectionView.dataSource = self
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
    
    func setupUI(){
        titleLabel.text = titl
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return centersInCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.configureCell(payload: centersInCategory[indexPath.row])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let centerId = centersInCategory[indexPath.row].id else {return}
         let center = SchoolDetailsViewController(centerId: centerId)
         navigationController?.pushViewController(center, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }

}
 
