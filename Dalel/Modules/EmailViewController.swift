//
//  EmailViewController.swift
//  Dalel
//
//  Created by  on 24/02/2022.
//

import UIKit
import MaterialComponents
import Alamofire
class EmailViewController: UIViewController,AuthenticationProtocol {

    @IBOutlet weak var enterEmailLabel: UIButton!{
        didSet{
            enterEmailLabel.setTitle("enterEmail".localizede, for: .normal)
            enterEmailLabel.setRoundCorners(10)
        }
    }
    @IBOutlet weak var emailTextField: MDCFilledTextField!{
        didSet{
            emailTextField.placeholder = "your email".localizede
        }
    }
    @IBOutlet weak var emterYourMailLabel: UILabel!{
        didSet{
            emterYourMailLabel.text = "enter your email".localizede
        }
    }
    
    var randomNumber = String()

    override func viewDidLoad() {
        super.viewDidLoad()
randomNumber = random(digits: 6)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterEmailAction(_ sender: Any) {
        guard let email = emailTextField.text,email.isValidEmail else {return}
        guard !randomNumber.isEmpty else {return}
        sendEmail(email: email)
    }
    
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
}

extension EmailViewController{
    func sendEmail(email:String){
        ActivityIndicatorManager.shared.showProgressView()
        APIs.genericApiWithPagination(pageNo: 0, url: "https://Dalil-taelim.com/api/notifications/send-via/email", method: .post, paameters: ["title":"verificationCode","email":email,"message":"your verification code is \(randomNumber)"], encoding: JSONEncoding.default, headers: Headers.AcceptContentHeader()) {[weak self]( mod:ModeModel?, err:Error?, code:Int?) in
            if [200,201].contains(mod?.code){
                HelperK.showSuccess(title: "go to your mail now".localizede, subtitle: "")
                let vc = VerificationViewController()
                vc.verificationCode = self?.randomNumber
                self?.navigationController?.pushViewController(vc, animated: true)
            }else{
                HelperK.showError(title: "try again".localizede, subtitle: "")
            }
        }
                                                                                                                        
    }
}
