//
//  OnBoardingViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class OnBoardingViewController: UIViewController {
//MARK: - Iboutlets
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    
    //MARK: - Vars
    var onBoardingList:[OnBoarding] =
    [OnBoarding(image: UIImage(named: "splash vector"), text: "weguideyou".localizede)
     ,OnBoarding(image: UIImage(named: "login 1") , text: "sign up now".localizede),
     OnBoarding(image:UIImage(named: "Untitled-1 2-1"), text: "on step to start your journey".localizede)]
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }

    func setupUI(){
        skipButton.setTitle("skip".localizede, for: .normal)
        textLabel.text = onBoardingList.first?.text ?? "ss"
        Image.image =  onBoardingList[0].image
        skipButton.setRoundCorners(10)
    }

    @IBAction func skipButton(_ sender: Any) {
        let login = UINavigationController(rootViewController: LanguageViewController.loadFromNib())
        login.modalPresentationStyle = .overFullScreen
        HelperK.saveType(Type: "customer")
        HelperK.saveKind(token: "customer")
        HelperK.saveFristTime(token: true)
        present(login, animated: true)
        
        
    }
    @IBAction func ChangeCurrentPage(_ sender: UIPageControl) {
        switch sender.currentPage {
        case 0 :
            textLabel.text = onBoardingList[0].text ?? ""
            Image.image = onBoardingList[0].image
            skipButton.setTitle("skip".localizede, for: .normal)
            skipButton.backgroundColor = .clear
            skipButton.setTitleColor(.white, for: .normal)
        case 1 :
            textLabel.text = onBoardingList[1].text ?? ""
            Image.image = onBoardingList[1].image
            skipButton.setTitle("skip".localizede, for: .normal)
            skipButton.backgroundColor = .clear
            skipButton.setTitleColor(.white, for: .normal)
        case 2 :
            textLabel.text = onBoardingList[2].text ?? ""
            Image.image = onBoardingList[2].image
            skipButton.setTitle("Start here".localizede, for: .normal)
            skipButton.backgroundColor = .white
            skipButton.setTitleColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .normal)
        default:
            return
        }
    }
}


