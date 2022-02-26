//
//  FaqsTermsViewModel.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa
class SettingViewModel:GeneralDataProtocol {
    let disposeBag = DisposeBag()
    let onLoading = BehaviorRelay<Bool>.init(value: false)
    let onError = PublishSubject<String>.init()
    let ConfigureRespsone = PublishSubject<GeneralModelPayload?>.init()
    
    func getData(){
        onLoading.accept(true)
        getGeneralData {[weak self]result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.ConfigureRespsone.onNext(response)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .none :
                return
            }
        }
    }
    
}
