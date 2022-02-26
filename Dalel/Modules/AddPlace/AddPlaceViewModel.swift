//
//  AddPlaceViewModel.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift
import UIKit
class AddPlaceViewModel:CenterProtocol {
    let disposeBag = DisposeBag()
    let onLoading = BehaviorRelay<Bool>.init(value: false)
    let onSuccess = PublishSubject<AddCenterModelPayload>()
    let serviceSuccess = PublishSubject<ServiceModelPayload?>.init()
    func uploadCenter(image:UIImage,arName:String,enName:String,desccriptionen:String,arDescription:String,phone:String,address:String,lat:String,lon:String,categoryID:String){
        onLoading.accept(true)
        addCenter(image: image, nameAr: arName, nameEn: enName, descriptionAr: arDescription, descriptionEn: desccriptionen, phone: phone, address: address, lat: lat, lon: lon, category:categoryID) {[weak self] result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {
                    return
                }
                
                self?.onSuccess.onNext(response)

            case .failure(let error):
                HelperK.showError(title: "error".localizede, subtitle: "")
            case .none :
                return
                
            }
        }
    }
    
    func addService(id:String,service:String){
        onLoading.accept(true)
        addService(id: id, service: service) {[weak self]result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let message = response?.message else {return}
                HelperK.showSuccess(title: message, subtitle: "")
                guard let services = response?.payload else {return}
                self?.serviceSuccess.onNext(services)
                
            case .failure(let error):
                HelperK.showError(title: "error".localizede, subtitle: "")
            case .none :
                return
            }
        }
    }
    
    func updateCenter(image:UIImage,arName:String,enName:String,desccriptionen:String,arDescription:String,phone:String,address:String,lat:String,lon:String,categoryID:String){
        
    }
}
