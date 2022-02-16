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
    case makeFavorite(id:String)
    case unFavorite(id:String)
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
            return "/centers/search"
        case .submitReview(let id ):
            return "/centers/\(id)/reviews/submit"
        case .listAllReviews(let id ):
            return "/centers/\(id)"
        case .makeFavorite(let id ):
            return "/centers/\(id)/mark-as-favorite"
        case .unFavorite(let id):
            return "/centers/\(id)/mark-as-unfavorite"
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
        case .submitReview,.unFavorite,.makeFavorite:
            return .post
        case .listAllReviews:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .center:
            return .requestPlain
        case .singleCenter:
            return .requestPlain
        case .searchInCenters(let key):
            return .requestParmters(parms: ["key":key], encoding: JSONEncoding.default)
        case .submitReview(let id,let review,let rate ):
            return .requestParmters(parms: ["review":review,"rate":rate], encoding: JSONEncoding.default)
        case .listAllReviews:
            return .requestPlain
        case .makeFavorite(id: let id):
            return.requestPlain
        case .unFavorite:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .center:
            return ["Authorization":"Bearer\(HelperK.getUserToken())","":""]
        case .singleCenter(let id):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        case .searchInCenters(let key):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        case .submitReview(let id,let review,let rate ):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        case .listAllReviews:
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        case .makeFavorite(id: let id):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        case .unFavorite(id: let id):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        }
    }
    
    
}
