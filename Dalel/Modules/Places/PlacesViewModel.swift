//
//  PlacesViewModel.swift
//  Dalel
//
//  Created by Shgardi on 20/02/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
class PlacesViewModel:ProfileProtocol {
    let disposeBag = DisposeBag()
    let onLoading = BehaviorRelay<Bool>.init(value: false)
    let onSuccess = PublishSubject<[PlacesModelPayload]?>()
    
    func getPlaces(){
        onLoading.accept(true)
        getPlaces {[weak self] result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.onSuccess.onNext(response)
            case .failure(let error):
                HelperK.showError(title: "error".localizede, subtitle: "")
            case .none :
                return
            }
        }
    }
}
