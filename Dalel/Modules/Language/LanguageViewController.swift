//
//  LanguageViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit
import RxCocoa
class LanguageViewController: UIViewController {
    @IBOutlet weak var chooseLanguage: UILabel!{
        didSet{
            chooseLanguage.text = "please choose language".localizede
        }
    }
    @IBOutlet weak var arab: UIStackView!{
        didSet{
            arab.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var eng: UIStackView!{
    didSet{
        eng.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
    }
}

    @IBOutlet weak var EnglishButton: UIButton!{
        didSet{
            EnglishButton.setTitle("english".localizede, for: .normal)
        }
    }
    @IBOutlet weak var ArabicButton: UIButton!{
        didSet{
            ArabicButton.setTitle("arabic".localizede, for: .normal)

        }
    }
    var viewModel = LanguageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupObserver()
    }

    func setupObserver(){
        EnglishButton.rx.tap.subscribe {[weak self] _ in
            LocalizationManager.shared.setLanguage(language: .English)
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()

            self?.navigate()
        }.disposed(by:viewModel.disposeBag )
        
        ArabicButton.rx.tap.subscribe {[weak self] _ in
            LocalizationManager.shared.setLanguage(language: .Arabic)
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()

            self?.navigate()

        }.disposed(by:viewModel.disposeBag )
    }
    
    func navigate(){
        let loginViewController = LoginViewController()
        let navigationViewController = UINavigationController(rootViewController: loginViewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true, completion: nil)
    }
}
