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
    
    let viewModel = AddCommentViewModel()
    var id :String?
    var rate : Int?
    
    init(id:String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        rate = sender.tag
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
    func setupViewModel(){
        
    }
    
    @IBAction func addCommentAction(_ sender: Any) {
        addCommentButton.secAnimation()
        guard let name = nameTextField.text , !name.isEmpty else {
            HelperK.showError(title: "enter your name".localizede, subtitle: "")
            return}
        guard let email = emailTextField.text , !email.isEmpty else {
            HelperK.showError(title: "enter your email".localizede, subtitle: "")
            return}
        guard let review = opinionsTextField.text , !review.isEmpty else {
            return
        }
        guard rate != nil else {return}
        viewModel.addComment(id: id ?? "", review: review, rate: rate ?? 0)
    }
    
   

}
