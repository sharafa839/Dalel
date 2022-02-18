//
//  SearchViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.configureCellSearch(payload: searchResult[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = searchResult[indexPath.row].id
        let center = SchoolDetailsViewController(centerId: id ?? "")
        navigationController?.pushViewController(center, animated: true)
    }

    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = SearchViewModel()
    var searchResult = [SearchModelPayload]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
       setupUIView()
        setupViewModel()
        subscribeViewModel()
        // Do any additional setup after loading the view.
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func setupUIView(){
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(CategoriesCollectionViewCell.nib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }
    
    func subscribeViewModel (){
        viewModel.searchResult.subscribe { [weak self] result in
            guard let search = result.element else {return}
            self?.searchResult.append(contentsOf: search)
            self?.searchCollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let key = searchBar.text , !key.isEmpty else {return}
        viewModel.getSearchResult(key: key)
    }
}

