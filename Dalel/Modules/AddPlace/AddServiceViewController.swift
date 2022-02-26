//
//  AddServiceViewController.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import UIKit
import Alamofire

class AddServiceViewController: UIViewController {

    @IBOutlet weak var addServiceForYourCenter: UILabel!{
        didSet{
            addServiceForYourCenter.text = "addServiceForYourCenter".localizede
        }
    }
    @IBOutlet weak var addSerivce: UIButton!{
        didSet{
            addSerivce.setTitle("addService".localizede, for: .normal)
            addSerivce.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var serviceTextField: UITextField!{
        didSet{
            serviceTextField.placeholder = "addService".localizede
            serviceTextField.floatView(raduis: 15, color: UIColor(named: "MainColor") ?? UIColor())
        }
        
    }
    var centerId:String?
    let viewModel = AddPlaceViewModel()
    init(id:String){
        self.centerId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subscribeViewModel()
    }
    
    func addService(){
        guard let service = serviceTextField.text , !service.isEmpty else {return}
        addService(id: centerId ?? "", title: service)
        addSerivce.secAnimation()
    }

    func subscribeViewModel(){
        viewModel.serviceSuccess.subscribe { service in
            HelperK.restartApp()
        }.disposed(by: viewModel.disposeBag)

    }
    @IBAction func addService(_ sender: UIButton) {
       addService()
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
extension AddServiceViewController{
    func addService(id:String,title:String){
        ActivityIndicatorManager.shared.showProgressView()
        APIs.genericApiWithPagination(pageNo: 0, url: "https://Dalil-taelim.com/api/centers/\(id)/services", method: .post, paameters: ["title":title], encoding: URLEncoding.default, headers: Headers.getHeader()) { (service:ServiceModel?, err:Error?, code:Int?) in
            ActivityIndicatorManager.shared.hideProgressView()

            if service?.code == 200 || service?.code == 201
            {
                HelperK.restartApp()
            }else{
                HelperK.showError(title: "err".localizede, subtitle: "")
            }
        }
    
    }
}
