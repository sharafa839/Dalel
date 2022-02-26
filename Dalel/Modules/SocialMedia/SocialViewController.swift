//
//  SocialViewController.swift
//  Dalel
//
//  Created by  on 20/02/2022.
//

import UIKit

class SocialViewController: UIViewController {

    @IBOutlet weak var twitter: UIButton!{
        didSet{
            twitter.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var youtube: UIButton!{
        didSet{
            youtube.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var instgram: UIButton!{
        didSet{
            instgram.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var facebook: UIButton!{
        didSet{
            facebook.floatButton(raduis: 15)
        }
    }
    
    let viewModel = SettingViewModel()
    var socialMediaData : Social?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getSocial()
        subscribeViewModel()
        setupViewModel()
    }

    func getSocial(){
        viewModel.getData()
    }
    
    func setupViewModel(){

        viewModel.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)

    
    }
    
    func subscribeViewModel(){
        viewModel.ConfigureRespsone.subscribe { [weak self] social in
            guard let socialMedia  = social.element else {return}
            self?.socialMediaData = socialMedia?.social
        }.disposed(by: viewModel.disposeBag)

    }

    @IBAction func openFaceBook(_ sender: UIButton) {
        HelperK.openFacebook(facebook: socialMediaData?.facebook ?? "")
    }
    @IBAction func openInstgram(_ sender: Any) {
        HelperK.openInstagram(instgram: socialMediaData?.instagram ?? "")

    }
    @IBAction func openYoutube(_ sender: Any) {
        HelperK.openyotube(instgram: socialMediaData?.youtube ?? "")
    }
    
    @IBAction func openTwitter(_ sender: UIButton) {
        HelperK.openTwitter(twitter: socialMediaData?.twitter ?? "")

    }
    
}
