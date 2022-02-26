//
//  HomeViewModel.swift
//  Dalel
//
//  Created by  on 11/02/2022.
//

import Foundation
import RxRelay
import RxRelay
import RxSwift
import Alamofire
class HomeViewModel:CategoriesProtocol,CenterProtocol,BannerProtocol {
    let onError = PublishSubject<String>()
    let onSuccess = PublishSubject<[CategoriesModelPayload]>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    let schoolResponse = PublishSubject<[CagtegoryCenterModelPayload]?>()
    let universityResponse = PublishSubject<[CagtegoryCenterModelPayload]?>()
    let kidsGardenResponse = PublishSubject<[CagtegoryCenterModelPayload]?>()
    let centersResponse = PublishSubject<[CenterModelPayload]>()
    let disposeBag = DisposeBag()
    let banners = PublishSubject<[BannerPayload]>()
    
    func getCategory(){
        guard ((NetworkReachabilityManager.default?.isReachable) != nil) else{return}
        onLoading.accept(true)
        categories {[weak self] result, failResult in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
return
            case .success(let response):
                guard let response = response?.payload else {return}
                self.onSuccess.onNext(response ?? [CategoriesModelPayload]())
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
                guard let response = response?.payload else {
                    return
                }
                self.centersResponse.onNext(response)
            case .none : return
            }
        }
    }
    
    func getSchools(id:String?){
        onLoading.accept(true)
        singleCategoryCenter(id: "cce5da55-9651-463c-b0cc-84280fc5a53f") { [weak self]result, failResult in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self.onError.onNext(error.localizedDescription)
            case.success(let response):
                guard let response = response?.payload else {
                    return
                }
                self.schoolResponse.onNext(response)
            case .none : return
            }
        }
    }
    
    func getKidsGarden(id:String?){
        onLoading.accept(true)
        singleCategoryCenter(id: "353c2229-17c7-4f01-bd16-dabcdc6473b3") { [weak self]result, failResult in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .failure(let error):
                self.onError.onNext(error.localizedDescription)
            case.success(let response):
                guard let response = response?.payload else {
                    return
                }
                self.kidsGardenResponse.onNext(response)
            case .none : return
            }
        }
    }
        
    func getUniversity(id:String?){
        onLoading.accept(true)
        singleCategoryCenter(id: "71f65e07-e816-4296-9dd5-8c48e3d785ea") { result, fail in
            switch result {
            case.failure(let error):
                self.onError.onNext(error.localizedDescription)
            case.success(let response):
                guard let response = response?.payload else {
                    return
                }
                self.universityResponse.onNext(response ?? response)
            case .none : return
            }
    }
    }

    func getBanners(){
        onLoading.accept(true)
        getBanners { [weak self]result, fail in
            guard let self = self else {return}
            self.onLoading.accept(false)
            switch result {
            case .success( let response):
                
                guard let response = response?.payload else {return}
                self.banners.onNext(response ?? [BannerPayload]())
            case .failure(let error):
                self.onError.onNext(error.localizedDescription)
            case .none:
                return
            }
        }
    }
    
}
