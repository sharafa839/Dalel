//
//  LoginViewModel.swift
//  Dalel
//
//  Created by  on 10/02/2022.
//

import Foundation
import RxSwift
import RxRelay
class LoginViewModel:AuthenticationProtocol{
    let password = BehaviorRelay<String>(value: "")
    let phoneNumber = BehaviorRelay<String>(value: "")
    let onError = PublishSubject<String>()
    let onSuccess = PublishSubject<LoginPayload>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    var isPhoneEmpty:Observable<Bool>{
        return phoneNumber.asObservable().map { (phonee) -> Bool in
            let myphone = phonee.isValidPhone
            return !myphone
        }
    }
    var isPasswordValid:Observable<Bool>{
        return password.asObservable().map { (passw) -> Bool in
            let mypass = passw.count > 5
            return mypass
        }
    }
    var isSignUpButtonIsEnabled:Observable<Bool>{
   
        return Observable.combineLatest(isPhoneEmpty,isPasswordValid){(phone,pass) in
            return (phone  && pass )
        }
    }
    
    func login(){
        onLoading.accept(true)
        login(phone: phoneNumber.value, password: password.value) { [weak self] result,failResult  in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let _):
                
                self.onError.onNext(failResult?.messages?.phone?.first ?? "err".localizede)
            case .success(let response):
                guard let response = response?.payload else {
                    return
                }
                guard let tokenType = response.tokenType else {return}
                guard let token = response.token else {return}
                guard let kind = response.userType else {return}
                HelperK.saveKind(token: kind)
                HelperK.saveToken(token: tokenType + "  " + token)
                self.onSuccess.onNext(response)
                
            }
        }
    }
}
