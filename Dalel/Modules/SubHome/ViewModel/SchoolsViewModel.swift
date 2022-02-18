//
//  SchoolsViewModel.swift
//  Dalel
//
//  Created by Shgardi on 17/02/2022.
//

import Foundation
import RxSwift
import RxRelay
class SubHomeViewModel:CategoriesProtocol{
    let disposeBag = DisposeBag()
    let onError = PublishSubject<String>()
    let onLoading = BehaviorRelay<Bool>(value: false)

    let categories = PublishSubject<[CagtegoryCenterModelPayload]>()
    
    func getCategory(id:String){
        onLoading.accept(true)
        singleCategoryCenter(id: id) {[weak self] result, fail in
            self?.onLoading.accept(false)
            switch result {
            case.none:
                return
            case .success(let response):
                guard let response = response?.payload else {return}
                self?.categories.onNext(response ?? [CagtegoryCenterModelPayload]())
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
}
