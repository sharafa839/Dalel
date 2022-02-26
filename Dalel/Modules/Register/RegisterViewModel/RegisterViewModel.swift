//
//  RegisterViewModel.swift
//  Dalel
//
//  Created by  on 05/02/2022.
//

import Foundation
import RxSwift
import RxRelay
class RegisterViewModel : AuthenticationProtocol{
    let name = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let phoneNumber = BehaviorRelay<String>(value: "")
    let phoneCode = BehaviorRelay<String>(value: "")
    let type = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let onError = PublishSubject<String>()
    let onSuccess = PublishSubject<LoginModel>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    var isEmailValid : Observable<Bool>{
        return email.asObservable().map { emails -> Bool in
            return emails.isValidEmail
    }
    }
    var isEmailEmpty:Observable<Bool>{
        return email.asObservable().map { (emails) -> Bool in
            return !emails.isEmpty
        }
    }
    var isFNameEmpty:Observable<Bool>{
        return name.asObservable().map { (fName) -> Bool in
            let firstName = fName.isEmpty
            return !firstName
        }
    }

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
   
        return Observable.combineLatest(isEmailEmpty,isPhoneEmpty,isFNameEmpty,isPasswordValid,isEmailValid){(email,phone,pass,name,isValid) in
            return (email && phone && pass && name&&isValid)
        }
    }
    func registerNewUser(data:Data?){
        onLoading.accept(true)
        register(data: data ?? Data(), name: name.value, email: email.value, password: password.value, phone: phoneNumber.value, phoneCode: "0" + phoneCode.value, type: type.value) {[weak self] result,failResult  in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
                
                self.onError.onNext(failResult?.messages?.phone?.first ?? "err".localizede)
            case .success(let response):
                guard let response = response?.payload else {
                    return
                }
                self.onSuccess.onNext(response)

            }
        }
    }
}
