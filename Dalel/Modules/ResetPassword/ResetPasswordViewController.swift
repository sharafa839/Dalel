//
//  ResetPasswordViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var reassignPasswordLabel: UILabel!{
        didSet{
            reassignPasswordLabel.text = "reassignPassword".localizede
        
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            nextButton.setTitle("next".localizede, for: .normal)
            nextButton.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            confirmPasswordTextField.placeholder = "confirmPass".localizede
            confirmPasswordTextField.floatView(raduis: 15, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.placeholder = "password".localizede
            passwordTextField.floatView(raduis: 15, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    let viewModel = ProfileViewModel()
    var isLogin : Bool? = true
    override func viewDidLoad() {
        super.viewDidLoad()
subscribeViewModel()
        setupViewModel()
    }
    func subscribeViewModel(){
        viewModel.password.subscribe {[weak self] pass in
            guard let self = self else {return}

            HelperK.showSuccess(title: "passwordChanged".localizede, subtitle: "")
            if self.isLogin!{
                self.navigationController?.popViewController(animated: true)
                
            }else{
                Router.setRoot()
            }
            
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
            HelperK.showError(title: "notMatch".localizede, subtitle: "")
            
        }else{
            nextButton.secAnimation()
            viewModel.password(password: password, passwordConfirm: passwordConfirm)
            
        }
    
    }
    

}
