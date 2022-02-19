//
//  ContactUsViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class ContactUsViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
  
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet{
            phoneTextField.keyboardType = .phonePad
        }
    }
    @IBOutlet weak var opinionsTextField: UITextField!
    @IBOutlet weak var addCommentButton: UIButton!
    let viewModel = ContactUsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
setupViewModel()
        setupUI()
        // Do any additional setup after loading the view.
    }


    func setupUI(){
      
        nameTextField.placeholder = "addYourName".localizede
        emailTextField.placeholder = "addYourEmail".localizede
        phoneTextField.placeholder = "addYourPhone".localizede
        opinionsTextField.placeholder = "addYourOpinion".localizede
        nameTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        phoneTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        emailTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        opinionsTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        
        addCommentButton.setRoundCorners(15)

    }
    @IBAction func addRevieww(_ sender: UIButton) {
        addCommentButton.secAnimation()
        guard let name = nameTextField.text , !name.isEmpty else{ return}
        guard let email = emailTextField.text, !email.isValidEmail else{  return}
        guard let phone = phoneTextField.text , !phone.isEmpty else {return}
        guard let message = opinionsTextField.text ,!message.isEmpty else{return}
        viewModel.getReview(name: name, email: email, phone: phone, message: message)
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

}
