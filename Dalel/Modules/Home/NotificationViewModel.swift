//
//  File.swift
//  Dalel
//
//  Created by Shgardi on 25/02/2022.
//

import Foundation
import RxSwift
import RxRelay
class NotificationViewModel:NotificationProtocol{
    let disposeBag = DisposeBag()
    let notificationList = PublishSubject<[NotificationModelPayload]>()
    let onError = PublishSubject<String>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    
    
    func getNotifications(){
        getNotifications {[weak self]result,fail in
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.notificationList.onNext(response ?? [NotificationModelPayload]())
            case .failure(let error):
                print(error.localizedDescription)
            case .none :
                return
            }
        }
    }
}
