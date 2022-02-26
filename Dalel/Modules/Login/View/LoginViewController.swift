//
//  LoginViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit
import MaterialComponents
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var welcomeBackLabel: UILabel!{
        didSet{
            welcomeBackLabel.text = "welcomeBack".localizede
        }
    }
    @IBOutlet weak var signInToContinue: UILabel!{
        didSet{
            signInToContinue.text  = "signInToContinue".localizede
        }
    }
    @IBOutlet weak var forgetPasswordOutlet: UIButton!{
        didSet{
            forgetPasswordOutlet.setTitle("did you forget your password".localizede, for: .normal)
        }
    }
    
    @IBOutlet weak var signInButton: UIButton!{
        didSet{
            signInButton.setTitle("signIn".localizede, for: .normal)
            signInButton.drawBorder(raduis: 10, borderColor: (UIColor(named: "MainColor") ?? UIColor.blue))
        }
    }
    @IBOutlet weak var youHaveNotLabel: UILabel!{
        didSet{
            youHaveNotLabel.text = "dontHaveaccount".localizede
        }
    }
    @IBOutlet weak var signUpButton: UIButton!{
        didSet{
            signUpButton.setTitle("signup".localizede, for: .normal)
        }
    }
    @IBOutlet weak var passwordTextField: MDCFilledTextField!{
        didSet{
            passwordTextField.label.text = "password".localizede
            passwordTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
            passwordTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            passwordTextField.setFilledBackgroundColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var phoneTextField: MDCFilledTextField!{
        didSet{
            phoneTextField.label.text = "phoneNumber".localizede
            phoneTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
            phoneTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            phoneTextField.setFilledBackgroundColor(.white, for: .normal)
            phoneTextField.keyboardType = .phonePad
        }
    }
    
    //MARK: - Vars
    var viewModel  = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
setupViewModel()
        setupObservables()
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

        viewModel.onSuccess.subscribe { [weak self] register in
            guard let self = self else {return}
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            
            let main = storyBoard.instantiateViewController(withIdentifier: "main")
            let home = UINavigationController(rootViewController:main )
            home.modalPresentationStyle = .overFullScreen
            self.present(home, animated: true, completion: nil)
            
        }.disposed(by: viewModel.disposeBag)
    }
    
    func setupObservables(){
        phoneTextField.rx.text.orEmpty.bind(to: viewModel.phoneNumber).disposed(by: viewModel.disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: viewModel.disposeBag)
        viewModel.isSignUpButtonIsEnabled.bind(to: signInButton.rx.isEnabled).disposed(by: viewModel.disposeBag)
    
        signUpButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            let registerVc = RegisterViewController()
            self.navigationController?.pushViewController(registerVc, animated: true)
            
        }.disposed(by: viewModel.disposeBag)

        signInButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.signInButton.secAnimation()
            self.viewModel.login()
            print(self.viewModel.phoneNumber.value)


        }.disposed(by: viewModel.disposeBag)
        
        forgetPasswordOutlet.rx.tap.subscribe { [weak self] _ in
            let forgetPassword = EmailViewController()
            self?.navigationController?.pushViewController(forgetPassword, animated: true)
        }.disposed(by: viewModel.disposeBag)
    }


}
