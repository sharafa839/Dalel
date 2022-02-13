//
//  VerificationViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var enterActivationCode: UILabel!
    @IBOutlet weak var makeSureButton: UIButton!
    @IBOutlet weak var messageIsSent: UILabel!
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

    @IBAction func makeSureAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
