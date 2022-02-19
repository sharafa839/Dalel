//
//  ResetPasswordViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var reassignPasswordLabel: UILabel!{
        didSet{
            reassignPasswordLabel.text = "reassignPassword"
        
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            nextButton.setTitle("next", for: .normal)
            nextButton.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            confirmPasswordTextField.placeholder = "confirmPass"
            confirmPasswordTextField.floatView(raduis: 15, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.placeholder = "pass"
            passwordTextField.floatView(raduis: 15, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    let viewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
subscribeViewModel()
        setupViewModel()
    }
    func subscribeViewModel(){
        viewModel.password.subscribe {[weak self] pass in
            HelperK.showSuccess(title: "passwordChanged", subtitle: "")
            self?.navigationController?.popViewController(animated: true)
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
    
    @IBAction func assignPasswordButton(_ sender: UIButton) {
        guard let password = passwordTextField.text , !password.isEmpty,password.count > 6 else {return}
        guard let passwordConfirm = confirmPasswordTextField.text , !passwordConfirm.isEmpty,passwordConfirm.count > 6 else {return}
        if passwordConfirm != password{
            HelperK.showError(title: "notMatch", subtitle: "")
            
        }else{
            nextButton.secAnimation()
            viewModel.password(password: password, passwordConfirm: passwordConfirm)
            
        }
    
    }
    

}
