//
//  VerificationViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var enterActivationCode: UILabel!{
        didSet{
            enterActivationCode.text = "enterActivationCode".localizede
        }
    }
    @IBOutlet weak var makeSureButton: UIButton!{
        didSet{
            makeSureButton.setTitle("makeSure".localizede, for: .normal)
            makeSureButton.addTarget(self, action: #selector(enteraCode), for: .touchUpInside)
        }
    }
    @IBOutlet weak var messageIsSent: UILabel!{
        didSet{
            messageIsSent.text = "messageIsSent".localizede
        }}
    @IBOutlet weak var codeNumberLabel: UILabel!
    @IBOutlet weak var _tf1: UITextField!
    @IBOutlet weak var _tf2: UITextField!
    @IBOutlet weak var _tf3: UITextField!
    @IBOutlet weak var _tf4: UITextField!
    @IBOutlet weak var _tf5: UITextField!
    @IBOutlet weak var _tf6: UITextField!
    var verificationCode:String?
    var enterCode : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
        self.setTranslucentForNavigation()
        _tf1.becomeFirstResponder()
        self.view.layoutIfNeeded()
    }
    
    func setupUI(){
        _tf1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf5.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf6.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField:UITextField) {
        let text=textField.text
        if text?.utf16.count == 1 {
            switch textField{
            case _tf1:_tf1.becomeFirstResponder()
            case _tf2:_tf2.becomeFirstResponder()
            case _tf3:_tf3.becomeFirstResponder()
            case _tf4:_tf4.becomeFirstResponder()
            case _tf5:_tf6.becomeFirstResponder()
            case _tf6:_tf6.resignFirstResponder()
            default:
                break
                
            }} }
    
    @objc func enteraCode(){
        makeSureButton.secAnimation()
        guard let  firstChar = _tf1.text , !firstChar.isEmpty else{return}
        guard let  secondChar = _tf2.text , !secondChar.isEmpty else{return}
        guard let  thirdChar = _tf3.text , !thirdChar.isEmpty else{return}
        guard let  fourthChar = _tf4.text , !fourthChar.isEmpty else{return}
        guard let  fifthChar = _tf5.text , !fifthChar.isEmpty else{return}
        guard let  sixthChar = _tf6.text , !sixthChar.isEmpty else{return}
enterCode = firstChar + secondChar + thirdChar + fourthChar + fifthChar + sixthChar
        
        if enterCode == verificationCode {
            let vc = ResetPasswordViewController()
            vc.isLogin = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
