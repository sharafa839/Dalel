//
//  ContactUsViewModel.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa
class ContactUsViewModel:ContactUsRepo{
    let disposeBag = DisposeBag()
    let onLoading = BehaviorRelay<Bool>.init(value: false)
    let onError = PublishSubject<String>.init()
    let ConfigureRespsone = PublishSubject<GeneralModelPayload?>.init()
    
    func getReview(name:String,email:String,phone:String,message:String){
        onLoading.accept(true)
        contactus(messgae: message, name: name, email: email, phone: phone) {[weak self]result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.message else {return}
                HelperK.showSuccess(title: response, subtitle: "")
            case .failure(let error):
                print("\(error.localizedDescription)")
            case .none :
                return
            }

        }
    }
}
