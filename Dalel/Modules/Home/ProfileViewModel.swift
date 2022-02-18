//
//  ProfileViewModel.swift
//  Dalel
//
//  Created by Shgardi on 17/02/2022.
//

import Foundation
import RxSwift
import RxRelay
import UIKit
class ProfileViewModel:ProfileProtocol {
    let disposeBag = DisposeBag()
    let onLoading = BehaviorRelay<Bool>.init(value:false)
   

    let profileData = PublishSubject<ProfileModelPayload>()
    let updateProfileData = PublishSubject<ProfileModelPayload>()
    let password = PublishSubject<ProfileModelPayload>()

    func getProfileData(){
        onLoading.accept(true)
        getProfile {[weak self] result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.profileData.onNext(response)
            case .failure(let error):
                HelperK.showError(title: error.localizedDescription, subtitle: "")
            case .none :
                return
            }
        }
    }
    
    func updateProfile(name:String,email:String,phone:String){
        onLoading.accept(true)
        updateProfile(name: name, email: email, phone: phone) {[weak self] result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.updateProfileData.onNext(response)
            case .failure(let error):
                HelperK.showError(title: error.localizedDescription, subtitle: "")
            case .none :
                return
            }
        }
    }
    
    func password(password:String,passwordConfirm:String){
        onLoading.accept(true)
        updateProfilepassword(password: password, confirmPassword: passwordConfirm){[weak self] result,fail in
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.password.onNext(response)
            case .failure(let error):
                HelperK.showError(title: error.localizedDescription, subtitle: "")
            case .none :
                return
            }
        }
    }
    
    func updateProfileLogo(image:UIImage){
        onLoading.accept(true)
        updateProfileLogo(logo: image) {[weak self] result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.profileData.onNext(response)
            case .failure(let error):
                HelperK.showError(title: error.localizedDescription, subtitle: "")

            case .none :
                return
                
            }
        }
    }

}
