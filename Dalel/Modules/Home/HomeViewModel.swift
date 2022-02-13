//
//  HomeViewModel.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
import RxRelay
import RxRelay
import RxSwift
class HomeViewModel:CategoriesProtocol,CenterProtocol {
    let onError = PublishSubject<String>()
    let onSuccess = PublishSubject<[[String:String?]]>()
    let schoolResponse = PublishSubject<[CenterModelPayload]>()
    let centersResponse = PublishSubject<[CenterModelPayload]>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    
    func getCategory(){
        onLoading.accept(true)
        categories {[weak self] result, failResult in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let response = response?.payload?.payload else {return}
                self.onSuccess.onNext(response)
            case .none:
                return
            }
        }
    }
    
    func listAllCenters(){
        onLoading.accept(true)
        centers {[weak self] result, failResponse in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self.onError.onNext(error.localizedDescription)
            case.success(let response):
                guard let response = response?.payload?.payload else {
                    return
                }
                self.schoolResponse.onNext(response)
            case .none : return
            }
        }
    }
    
    func getSchools(id:String){
        onLoading.accept(true)
        singleCenter(id: id) { [weak self]result, failResult in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self.onError.onNext(error.localizedDescription)
            case.success(let response):
                guard let response = response?.payload?.payload else {
                    return
                }
                self.schoolResponse.onNext(response)
            case .none : return
            }
        }
    }
    
    
}
