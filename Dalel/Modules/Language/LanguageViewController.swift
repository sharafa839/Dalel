//
//  LanguageViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit
import RxCocoa
class LanguageViewController: UIViewController {
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

    @IBOutlet weak var EnglishButton: UIButton!
    @IBOutlet weak var ArabicButton: UIButton!
    var viewModel = LanguageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupObserver()
    }

    func setupObserver(){
        EnglishButton.rx.tap.subscribe {[weak self] _ in
            LocalizationManager.shared.setLanguage(language: .English)
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            self?.navigate()
        }.disposed(by:viewModel.disposeBag )
        
        ArabicButton.rx.tap.subscribe {[weak self] _ in
            LocalizationManager.shared.setLanguage(language: .Arabic)
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
            self?.navigate()

        }.disposed(by:viewModel.disposeBag )
    }
    
    func navigate(){
        let loginViewController = LoginViewController()
        let navigationViewController = UINavigationController(rootViewController: loginViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
}
