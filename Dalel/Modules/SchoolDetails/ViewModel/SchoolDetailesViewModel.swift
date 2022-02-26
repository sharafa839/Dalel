//
//  SchoolDetailesViewModel.swift
//  Dalel
//
//  Created by  on 16/02/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
class SchoolDetailsViewModel:CenterProtocol{
    let onError = PublishSubject<String>()
    let singleCenter = PublishSubject<SingleCenterPayload>()
    let reviews = PublishSubject<[ReviewsModelPayload]>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    let markAsFavorite = PublishSubject<Bool>()
    let disposeBag = DisposeBag()

    
    
    func getCenterData(id:String){
        onLoading.accept(true)
        singleCenter(id: id) { [weak self]result, fail in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
return
            case .success(let response):
                guard let response = response?.payload else {return}
                self?.singleCenter.onNext(response)
            case.none :
                return
            }
        }
    }
    func getCenterReviews(id:String){
        onLoading.accept(true)
        getReviews(id: id) {[weak self] result, fail in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let response = response?.payload else {return}
                self?.reviews.onNext(response)
            case.failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case.none:
                return
            }
        }
    }
    
    func makeFavorite(id:String){
        onLoading.accept(true)
        makeFavorite(id: id) { [weak self]result, fail in
            self?.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            case .success(let response):
                guard let response = response?.message else {return}
                HelperK.showSuccess(title: response, subtitle: "")
                self?.markAsFavorite.onNext(true)
            case .none:
                return
            }
        }
    }
    
    
    func makeUnFavorite(id:String){
        makeFavorite(id: id){[weak self]result, fail in
               self?.onLoading.accept(false)
               switch result {
               case .failure(let error):
                   self?.onError.onNext(error.localizedDescription)
               case .success(let response):
                   guard let response = response?.message else {return}
                   HelperK.showSuccess(title: response, subtitle: "")
                   self?.markAsFavorite.onNext(false)
               case .none:
                   return
               }
           }
        }

}
