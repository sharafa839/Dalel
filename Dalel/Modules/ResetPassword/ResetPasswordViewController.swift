//
//  ResetPasswordViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit
import Moya

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
    var email :String?
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
        if isLogin == true {
        guard let password = passwordTextField.text , !password.isEmpty,password.count > 6 else {return}
        guard let passwordConfirm = confirmPasswordTextField.text , !passwordConfirm.isEmpty,passwordConfirm.count > 6 else {return}
        if passwordConfirm != password{
            HelperK.showError(title: "notMatch".localizede, subtitle: "")
            
        }else{
            nextButton.secAnimation()
            viewModel.password(password: password, passwordConfirm: passwordConfirm)
            
        }
    
        }else{
            resetPassword()
        }
    

}
}
extension ResetPasswordViewController {
    func resetPassword(){
        guard let password = passwordTextField.text , !password.isEmpty,password.count > 6 else {return}
        guard let passwordConfirm = confirmPasswordTextField.text , !passwordConfirm.isEmpty,passwordConfirm.count > 6 else {return}
        if passwordConfirm != password{
            HelperK.showError(title: "notMatch".localizede, subtitle: "")
            
        }else{
            APIs.genericApiWithPagination(pageNo: 0, url: "https://Dalil-taelim.com/api/password/reset-by-email", method: .patch, paameters: ["email":email ?? "","password":password,"password_confirmation":passwordConfirm], encoding: URLEncoding.default, headers: Headers.ContentTypeAccept()) { (mode:ModeModel?,error:Error?,code:Int?) in
                if mode?.code == 200 || mode?.code == 201{
                HelperK.showSuccess(title: "passwordChanged".localizede, subtitle: "")
                }else{
                    HelperK.showSuccess(title: "try again".localizede, subtitle: "")

                }
            }
        }
        
       
    }
}
