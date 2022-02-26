//
//  FavoriteViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        cell.deleteBButton.tag = indexPath.row
        cell.deleteBButton.addTarget(self, action: #selector(deleteItem(sender:)), for: .touchUpInside)
        cell.configure(favorite: favorites[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120,height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = favorites[indexPath.row].id
        let vcDetail = SchoolDetailsViewController(centerId: item ?? "")
        self.navigationController?.pushViewController(vcDetail, animated: true)
    }
    

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    let viewModel = FavoriteViewModel()
    let centerFavorite = SchoolDetailsViewModel()
    var favorites = [FavoriteModelPayload]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorite()
        setupLocalization()
        subscribeViewModel()
        getFavorite()
        setupViewModel()
        setupCollectionView()
        setupViewModelLoading()
    }
    
    func setupLocalization(){
        title  = "Favorite".localizede
    }
    
    func setupCollectionView(){
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(FavoriteCollectionViewCell.nib, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    }
    
    func getFavorite(){
        viewModel.getFavorite()
    }
    
    func subscribeViewModel(){
        viewModel.onSuccess.subscribe {[weak self] favorites in
            guard let favs = favorites.element else{return}
            self?.favorites.append(contentsOf: favs)
            self?.favoriteCollectionView.reloadData()
            
        }.disposed(by: viewModel.disposeBag)
        
        centerFavorite.markAsFavorite.subscribe { [weak self]isFavorite in
            if !(isFavorite.element ?? false) {
                self?.favoriteCollectionView.reloadData()
            }
        }.disposed(by: centerFavorite.disposeBag)

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
    @objc func deleteItem(sender:UIButton){
        removeItem(id: favorites[sender.tag].id ?? "")
        
        let indexPath = IndexPath(item: sender.tag, section: 0)

        favoriteCollectionView.deleteItems(at: [indexPath])
        favoriteCollectionView.reloadData()

        favorites.remove(at: sender.tag)

    }
    
    func removeItem(id:String){
        centerFavorite.makeUnFavorite(id: id)
        
     
    }
    func setupViewModelLoading(){
        centerFavorite.onError.subscribe {  error in
            
            HelperK.showError(title: error.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        centerFavorite.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)

    
    }
    
}
