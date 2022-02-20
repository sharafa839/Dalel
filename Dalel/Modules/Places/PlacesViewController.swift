//
//  PlacesViewController.swift
//  Dalel
//
//  Created by Shgardi on 20/02/2022.
//

import UIKit

class PlacesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    let viewModel = PlacesViewModel()
    var places = [PlacesModelPayload]()
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placesLabel: UILabel!{
        didSet{
            placesLabel.text = "My Places"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        attachModel()
                subscribeViewModel()
                setupViewModel()
        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    func attachModel(){
        viewModel.getPlaces()
    }
    
    func subscribeViewModel(){
        viewModel.onSuccess.subscribe {[weak self] myPlace in
            guard let places = myPlace.element else{return}
            self?.places.append(contentsOf: places ?? [PlacesModelPayload]())
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)

    }
    
    
    func setupViewModel(){
   
        viewModel.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)

    
    }
    
    func setupTableView(){
        tableView.register(PlacesTableViewCell.nib, forCellReuseIdentifier: PlacesTableViewCell.identifier)
        tableView.rowHeight = 140
        tableView.delegate = self
        tableView.dataSource = self
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifier, for: indexPath) as! PlacesTableViewCell

        cell.configure(place: places[indexPath.row])
         cell.deleteButton.tag = indexPath.row
         cell.deleteButton.addTarget(self, action: #selector(deleteItem(sender:)), for: .touchUpInside)

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = places[indexPath.row]
        let addPlace = AddPlaceViewController()
         addPlace.place = item
        self.present(addPlace, animated: true, completion: nil)
        
    }

    @objc func deleteItem(sender:UIButton){
        removeItem(id: places[sender.tag].id ?? "")
    }
    
}

extension PlacesViewController {
    func removeItem(id:String){
        APIs.genericApiWithPagination(pageNo: 0, url: "https://Dalil-taelim.com/api/centers/\(id)", method: .delete, paameters: nil, headers: Headers.getHeader()) { [weak self](mode:ModeModel?, err:Error?, code:Int?) in
            if  [200,201].contains(mode?.code){
                self?.tableView.reloadData()
                HelperK.showSuccess(title: "delted".localizede, subtitle: "")
            }else{
                HelperK.showError(title: "error".localizede, subtitle: "")
            }
        }
    }
}
