//
//  CenterApi.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
import Alamofire
enum Centers{
    case center
    case singleCenter(id:String)
    case searchInCenters(key:String)
    case submitReview(id:String,review:String,rate:Int)
    case listAllReviews(id:String)
}
extension Centers:TargetType{
    var baseURL: String {
        switch self {
        default:
            return "https://Dalil-taelim.com/api"
        }
    }
    
    var path: String {
        switch self {
        case .center:
            return "/centers"
        case .singleCenter(let id):
            return "/centers/\(id)"
        case .searchInCenters:
            return "centers/search"
        case .submitReview(let id ):
            return "centers/\(id)/reviews/submit"
        case .listAllReviews(let id ):
            return "centers/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .center:
            return .get
        case .singleCenter:
            return .get
        case .searchInCenters:
            return .get
        case .submitReview:
            return .post
        case .listAllReviews:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .center:
            return .requestPlain
        case .singleCenter(let id):
            return .requestPlain
        case .searchInCenters(let key):
            return .requestParmters(parms: ["key":key], encoding: JSONEncoding.default)
        case .submitReview(let id,let review,let rate ):
            return .requestParmters(parms: ["review":review,"rate":rate], encoding: JSONEncoding.default)
        case .listAllReviews:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
