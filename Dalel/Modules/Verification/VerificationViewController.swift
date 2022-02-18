//
//  VerificationViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var enterActivationCode: UILabel!{
        didSet{
            enterActivationCode.text = "enterActivationCode".localizede
        }
    }
    @IBOutlet weak var makeSureButton: UIButton!
    @IBOutlet weak var messageIsSent: UILabel!{
        didSet{
        messageIsSent.text = "messageIsSent"
        }}
    @IBOutlet weak var codeNumberLabel: UILabel!
    @IBOutlet weak var _tf1: UITextField!
    @IBOutlet weak var _tf2: UITextField!
    @IBOutlet weak var _tf3: UITextField!
    @IBOutlet weak var _tf4: UITextField!
    @IBOutlet weak var _tf5: UITextField!
    @IBOutlet weak var _tf6: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

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
                
            }} else{ }}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
