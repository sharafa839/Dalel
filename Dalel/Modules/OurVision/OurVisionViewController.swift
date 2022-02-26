//
//  OurVisionViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class OurVisionViewController: UIViewController {

    @IBOutlet weak var ourVisionLabbel: UILabel!
        let viewModel = SettingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModel()
        subscribeViewModel()
        setupViewModel()
        // Do any additional setup after loading the view.
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
    func attachViewModel(){
        viewModel.getData()
    }
    
    func subscribeViewModel(){
        viewModel.ConfigureRespsone.subscribe {[weak self] data in
            guard let about = data.element else {return}
            self?.ourVisionLabbel.text = about?.about?.vision?.html2String
        }.disposed(by: viewModel.disposeBag)

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
