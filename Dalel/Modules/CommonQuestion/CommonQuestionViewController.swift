//
//  CommonQuestionViewController.swift
//  Dalel
//
//  Created by  on 20/02/2022.
//

import UIKit

class CommonQuestionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FaqsQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier) as! QuestionTableViewCell
        if LocalizationManager.shared.getLanguage() == .Arabic {
            cell.questionLabel.text = FaqsQuestion[indexPath.row].arQuestion

        }else{
            cell.questionLabel.text = FaqsQuestion[indexPath.row].enQuestion

        }
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = "FAQS".localizede
        }
    }
    let viewModel = FAQSViewModel()
    var FaqsQuestion = [FAQSPayload]()
    override func viewDidLoad() {
        super.viewDidLoad()
getData()
        subscribeViewModel()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuestionTableViewCell.nib, forCellReuseIdentifier: QuestionTableViewCell.identifier)
    }

    
    func getData(){
        viewModel.getData()
    }
    
    func subscribeViewModel(){
        viewModel.ConfigureRespsone.subscribe {[weak self] questions in
            guard let ques = questions.element else {return}
            self?.FaqsQuestion.append(contentsOf: ques ?? [FAQSPayload]())
            self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = FaqsQuestion[indexPath.row]
        
        let faqVC = ASKAnswerViewController()
        faqVC.data = cell
        present(faqVC, animated: true, completion: nil)
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

