//
//  ProfileViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit
import MaterialComponents
import FlagPhoneNumber
import iOSDropDown
import Gallery
class ProfileViewController: UIViewController, UITextFieldDelegate, GalleryControllerDelegate {

    @IBOutlet weak var userName: UILabel!{
        didSet{
            userName.text = "userName".localizede
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: MDCFilledTextField!{
        didSet{
            nameTextField.label.text = "FullNAme".localizede
            nameTextField.setUnderlineColor(.gray, for: .normal)
            nameTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            nameTextField.setFilledBackgroundColor(.white, for: .normal)
            nameTextField.isEnabled = false

        }
    }
    @IBOutlet weak var emailTextField: MDCFilledTextField!{
        didSet{
            emailTextField.label.text = "email".localizede
            emailTextField.setUnderlineColor(.gray, for: .normal)
            emailTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            emailTextField.setFilledBackgroundColor(.white, for: .normal)
            emailTextField.isEnabled = false

        }
    }
    @IBOutlet weak var genderTextField: DropDown!{
        didSet{
            genderTextField.optionArray = ["male".localizede,"female".localizede]
        }
    }
    @IBOutlet weak var passwordTextField: MDCFilledTextField!{
        didSet{
            passwordTextField.label.text = "password".localizede
            passwordTextField.setUnderlineColor(.gray, for: .normal)
            passwordTextField.setUnderlineColor(UIColor(named: "MainColor") ?? UIColor.blue, for: .editing)
            passwordTextField.setFilledBackgroundColor(.white, for: .normal)
            passwordTextField.isEnabled = false
        }
    }
    @IBOutlet weak var containerView: UIView!{didSet{
        containerView.floatView(raduis: containerView.frame.width / 2 , color: UIColor(named: "MainColor") ?? UIColor())
    }}
    @IBOutlet weak var phoneTextField: FPNTextField!
    
    @IBOutlet weak var changePhoto: UIButton!{
        didSet{
            changePhoto.setTitle("changePhoto".localizede, for: .normal)
        }
    }
    @IBOutlet weak var editButton: UIButton!{
        didSet{
            editButton.setTitle("edit".localizede, for: .normal)
            editButton.floatView(raduis: 15, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.setRoundCorners(profileImageView.frame.width / 2)
            profileImageView.addActionn(vc: self, action: #selector(updateProfile))

        }
    }
    var pickedImg: UIImage?
    var arrayOfImage:[UIImage?] = []
    var gallary = GalleryController()
    var profileData : ProfileModelPayload?
    let viewModel = ProfileViewModel()
    var availability : Availability = .disable
    override func viewDidLoad() {
        super.viewDidLoad()
title = "Profile"
        attachViewModel()
        setupUI()
        subscribeToViewModel()
        setupViewModel()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAvailability(isEnable: false)
        availability = .disable
    }
    private func attachViewModel(){
        viewModel.getProfileData()
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
    
    @objc func updateProfile(){
        gallary = GalleryController()
        gallary.delegate = self
            Config.tabsToShow = [.cameraTab,.imageTab]
            Config.Camera.imageLimit = 1
            self.present(self.gallary,animated: true,completion: nil)
    }
    
    private func subscribeToViewModel(){
        viewModel.profileData.subscribe { [weak self] profile in
            guard let profile = profile.element else {return}
            self?.setupView(profile: profile)
        }.disposed(by: viewModel.disposeBag)
        viewModel.updateProfileData.subscribe {[weak self] profile in
            guard let profile = profile.element else {return}
            self?.setupView(profile: profile)
        }.disposed(by: viewModel.disposeBag)

        

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let passwordVc = ResetPasswordViewController()
        navigationController?.pushViewController(passwordVc, animated: true)
    }
    
    func setupAvailability(isEnable:Bool){
        phoneTextField.isEnabled = isEnable
        emailTextField.isEnabled = isEnable
        nameTextField.isEnabled = isEnable
        genderTextField.isEnabled = isEnable
        profileImageView.isUserInteractionEnabled = isEnable
        changePhoto.isEnabled = isEnable
        passwordTextField.isEnabled = isEnable
    }
    
    func setupUI(){
        genderTextField.didSelect { selectedText, index, id in
            HelperK.saveKind(token: selectedText)
            
        }
        phoneTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    
    func setupView(profile:ProfileModelPayload){
        nameTextField.text = profile.fullName
        phoneTextField.text = profile.phone
        phoneTextField.selectedCountry?.phoneCode = profile.phoneCode ?? ""
        emailTextField.text = profile.email
        passwordTextField.text = "*********"
        guard let profile = profile.logoURL else {return}
        profileImageView.downlodImage(str: "https://Dalil-taelim.com" + profile)
        genderTextField.text = HelperK.getkind()
        
    }
    
    @IBAction func changePhotoAction(_ sender: UIButton) {updateProfile()    }
    
    @IBAction func saveEdit(_ sender: UIButton) {
        switch availability {
        case .enable:
            availability = .disable
            setupAvailability(isEnable: false)
            editButton.setTitle("edit".localizede, for: .normal)
            guard let phone = phoneTextField.text , !phone.isEmpty else {return}
            guard let email = emailTextField.text , !email.isEmpty else {return}
            guard let name =  nameTextField.text , !name.isEmpty else {return}
            viewModel.updateProfile(name: name, email: email, phone: phone)
        case .disable:
            editButton.setTitle("save".localizede, for: .normal)
            setupAvailability(isEnable: true)
            availability = .enable

        }
       
        
    }
    
    enum Availability{
        case enable
        
        case disable
    }
    
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { [weak self] (resolvedImage) in
               
             
                    self?.arrayOfImage = resolvedImage
                    self?.pickedImg = self?.arrayOfImage.first as? UIImage
                self?.viewModel.updateProfileLogo(image: self?.pickedImg ?? UIImage())
           
        controller.dismiss(animated: true, completion: nil)
            }}
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)

    }

}
