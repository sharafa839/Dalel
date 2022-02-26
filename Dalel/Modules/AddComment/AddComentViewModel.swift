//
//  AddComentViewModel.swift
//  Dalel
//
//  Created by  on 17/02/2022.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire
class AddCommentViewModel:CenterProtocol {
    let disposeBag = DisposeBag()

    
    func addComment(id:String,review:String,rate:Int){
//        submitReview(id: id, review: review, rate: rate) { result, fail in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case.success(let response):
//                guard let response = response?.payload else {
//                    return
//                }
//
//                HelperK.showSuccess(title: "Thanks for your review".localizede, subtitle: "")
//            case .none:
//                return
//            }
//        }
        APIs.genericApiWithPagination(pageNo: 0, url: "https://Dalil-taelim.com/api/centers/\(id)/reviews/submit", method: .post, paameters: ["review":review,"rate":rate], encoding: URLEncoding.default, headers: Headers.getHeader()) { (mode:ModeModel?, err:Error?, code:Int?) in
            if [200,201].contains(mode?.code) {
                HelperK.showSuccess(title: "thanks", subtitle: "")
            }
        }
    }
}
