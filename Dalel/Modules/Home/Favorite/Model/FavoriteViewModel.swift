//
//  File.swift
//  Dalel
//
//  Created by  on 21/02/2022.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift
class FavoriteViewModel:ProfileProtocol{
    let onError = PublishSubject<String>()
    let onSuccess = PublishSubject<[FavoriteModelPayload]>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    func getFavorite(){
        onLoading.accept(true)
        getFavorites{[weak self]result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.onSuccess.onNext(response)
            case .failure(let error):
                print(error.localizedDescription)
            case .none :
                return
                
            }
            
        }
    }
}
