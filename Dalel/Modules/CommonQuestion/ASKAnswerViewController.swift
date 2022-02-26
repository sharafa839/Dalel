//
//  ASKAnswerViewController.swift
//  Dalel
//
//  Created by  on 20/02/2022.
//

import UIKit

class ASKAnswerViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    var data : FAQSPayload?
    override func viewDidLoad() {
        super.viewDidLoad()
        if LocalizationManager.shared.getLanguage() == .Arabic{
            questionLabel.text = data?.arQuestion?.html2String
            answerLabel.text = data?.arAnswer?.html2String
        }else{
            questionLabel.text = data?.enQuestion?.html2String
            answerLabel.text = data?.enAnswer?.html2String
        }
       
        // Do any additional setup after loading the view.
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
