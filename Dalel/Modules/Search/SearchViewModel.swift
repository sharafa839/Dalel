//
//  SearchViewModel.swift
//  Dalel
//
//  Created by  on 17/02/2022.
//

import Foundation
import RxSwift
import RxRelay
class SearchViewModel :CenterProtocol{
    let disposeBag = DisposeBag()
    let searchResult = PublishSubject<[SearchModelPayload]>()
    let onError = PublishSubject<String>()
    let onLoading = BehaviorRelay<Bool>(value: false)
    func getSearchResult(key:String){
        onLoading.accept(true)
        searchInCenters(keyword: key) { [weak self]result,fail in
            self?.onLoading.accept(false)
            switch result {
            case.success(let response):
                guard let response = response?.payload else {return}
                self?.searchResult.onNext(response)
            case .failure(let error):
return
            case .none :
                return
            }
        }
    }
    
}
