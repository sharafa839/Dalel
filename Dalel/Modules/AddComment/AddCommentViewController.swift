//
//  AddCommentViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit

class AddCommentViewController: UIViewController {
    @IBOutlet weak var _1stButton: UIButton!{didSet{
        
    }}
    @IBOutlet weak var _2stButton: UIButton!
    @IBOutlet weak var _3stButton: UIButton!
    @IBOutlet weak var _4stButton: UIButton!
    @IBOutlet weak var _5stButton: UIButton!
    @IBOutlet weak var addReviewLabel: UILabel!{
        didSet{
            addReviewLabel.text = "addReview".localizede
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var rateInText: UILabel!{
        didSet{
            rateInText.text = "0/5"
        }
    }
    @IBOutlet weak var opinionsTextField: UITextField!
    @IBOutlet weak var addCommentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        _1stButton.imageView?.tintColor = .gray
        _2stButton.imageView?.tintColor = .gray
        _3stButton.imageView?.tintColor = .gray
        _4stButton.imageView?.tintColor = .gray
        _5stButton.imageView?.tintColor = .gray
        nameTextField.placeholder = "addYourName".localizede
        emailTextField.placeholder = "addYourEmail".localizede
        opinionsTextField.placeholder = "addYourOpinion".localizede
        nameTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        emailTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        opinionsTextField.drawBorder(raduis: 10, borderColor: UIColor(named: "MainColor") ?? UIColor())
        
        addCommentButton.setRoundCorners(15)

    }
    @IBAction func rateButton(_ sender: UIButton) {
        rateInText.text = "(\(sender.tag)/5)"
        switch sender.tag {
            
        case 1:
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .gray
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case 2:
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case 3:
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case 4:
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .systemYellow
            _5stButton.imageView?.tintColor = .gray

        case 5:
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .systemYellow
            _5stButton.imageView?.tintColor = .systemYellow

        default:
            return
        }
        
    }
    @IBAction func addCommentAction(_ sender: Any) {
    }
    
   

}
