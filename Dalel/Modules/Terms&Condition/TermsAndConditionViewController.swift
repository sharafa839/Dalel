//
//  TermsAndConditionViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class TermsAndConditionViewController: UIViewController {

    @IBOutlet weak var TermsTextView: UITextView!{
        didSet{
            TermsTextView.isEditable = false
        }
    }
    
    let viewModel = SettingViewModel()
override func viewDidLoad() {
    super.viewDidLoad()
    attachViewModel()
    subscribeViewModel()
    setupViewModel()
}

func attachViewModel(){
    viewModel.getData()
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
func subscribeViewModel(){
    viewModel.ConfigureRespsone.subscribe {[weak self] data in
        guard let about = data.element else {return}
        self?.TermsTextView.text = about?.about?.termsAndConditions?.html2String
    }.disposed(by: viewModel.disposeBag)

}
}
