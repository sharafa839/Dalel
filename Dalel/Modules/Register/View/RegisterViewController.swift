//
//  RegisterViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit
import MaterialComponents
import FlagPhoneNumber
import iOSDropDown
import RxSwift
import RxRelay
import RxCocoa
class RegisterViewController: UIViewController {
//MARK: - IBoutlets
    @IBOutlet weak var createNewAccountLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var pleaseFillTextLabel: UILabel!
    @IBOutlet weak var fullNameTextField: MDCFilledTextField!{
        didSet{
            fullNameTextField.label.text = "FullNAme"
            fullNameTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
            fullNameTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            fullNameTextField.setFilledBackgroundColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var phoneCode: FPNTextField!
   
    @IBOutlet weak var phoneNumberTextField: MDCFilledTextField!{
        didSet{
            phoneNumberTextField.label.text = "phoneNumber"
            phoneNumberTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
            phoneNumberTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            phoneNumberTextField.setFilledBackgroundColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var emailTextField: MDCFilledTextField!{
        didSet{
            emailTextField.label.text = "email"
            emailTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
            emailTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            emailTextField.setFilledBackgroundColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var passwordTextField: MDCFilledTextField!{
        didSet{
            passwordTextField.label.text = "password"
            passwordTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
            passwordTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            passwordTextField.setFilledBackgroundColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var youHaveAccountLabel: UILabel!{
        didSet{
            youHaveAccountLabel.text = "you have account"
        }
    }
    @IBOutlet weak var registerButtonOutlet: UIButton!{
        didSet{
            registerButtonOutlet.setTitle("signUp", for: .normal)
            registerButtonOutlet.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor.blue)
        }
    }
    @IBOutlet weak var signInOutlet: UIButton!{
        didSet{
            signInOutlet.setTitle("signIn", for: .normal)
        }
    }
    
    
    @IBOutlet weak var typeOfClient: DropDown!{
        didSet{
            typeOfClient.optionArray = ["customer","center owner"]
            typeOfClient.text = "choose your major"
        }
    }
    
    //MARK: - Properties
    var viewModel = RegisterViewModel()
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

       setupObservables()
        setupViewModel()
        setupUI()
    }
    
    
    
    //MARK: - Methods
    func setupObservables(){
        fullNameTextField.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: viewModel.disposeBag)
        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: viewModel.disposeBag)
        //phoneCode.rx.text.orEmpty.bind(to: viewModel.phoneCode).disposed(by: viewModel.disposeBag)
       // phoneNumberTextField.rx.text.orEmpty.bind(to: viewModel.phoneNumber).disposed(by: viewModel.disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: viewModel.disposeBag)
        typeOfClient.rx.text.orEmpty.bind(to: viewModel.type).disposed(by: viewModel.disposeBag)
        viewModel.isSignUpButtonIsEnabled.bind(to: registerButtonOutlet.rx.isEnabled).disposed(by: viewModel.disposeBag)
    
        signInOutlet.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            let signIn = LoginViewController()
            self.present(signIn, animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)

        registerButtonOutlet.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.registerButtonOutlet.secAnimation()
            self.viewModel.registerNewUser()
            print(self.viewModel.name.value)
            print(self.viewModel.phoneCode.value)
            print(self.viewModel.phoneNumber.value)
            print(self.viewModel.type.value)


        }.disposed(by: viewModel.disposeBag)
    }
    
    func setupUI(){
        typeOfClient.didSelect { selectedText, index, id in
            self.viewModel.type.accept(selectedText)
        }
        phoneCode.delegate = self

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
//            let main = HomeTableViewController()
//            let home = UINavigationController(rootViewController:main )
//            home.modalPresentationStyle = .fullScreen
//            self.present(home, animated: true, completion: nil)
            Alert.alertPopUp(title: "Great !", msg:"wait to approve" , btnTitle: "ok", vc: self)
            
        }.disposed(by: viewModel.disposeBag)
    }

}
extension RegisterViewController: FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
        return
    }
    


   /// Lets you know when a country is selected
   func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
      print(name, dialCode, code) // Output "France", "+33", "FR"
       viewModel.phoneCode.accept(dialCode)
   }

   /// Lets you know when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966)
   func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
      if isValid {
          viewModel.phoneNumber.accept(textField.getRawPhoneNumber() ?? "")
      } else {
         // Do something...
      }
   }
}
