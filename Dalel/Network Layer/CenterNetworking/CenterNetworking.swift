//
//  CenterApi.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
import Alamofire
import Moya
enum Centers{
    case center
    case singleCenter(id:String)
    case searchInCenters(key:String)
    case submitReview(id:String,review:String,rate:Int)
    case listAllReviews(id:String)
    case makeFavorite(id:String)
    case unFavorite(id:String)
    case addCenter(arName:String,enName:String,desccriptionen:String,arDescription:String,phone:String,address:String,lat:String,lon:String)
    case addService(id:String,title:String)
    
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
        case .searchInCenters(let key):
            return "/centers/search?keyword=\(key)"
        case .submitReview(let id ):
            return "/centers/\(id)/reviews/submit"
        case .listAllReviews(let id ):
            return "/centers/\(id)/reviews/list"
        case .makeFavorite(let id ):
            return "/centers/\(id)/mark-as-favorite"
        case .unFavorite(let id):
            return "/centers/\(id)/mark-as-unfavorite"
        case .addCenter(arName: let arName, enName: let enName, desccriptionen: let desccriptionen, arDescription: let arDescription, phone: let phone, address: let address, lat: let lat, lon: let lon):
            return "/centers"
        case .addService(id: let id):
            return "/centers/\(id)/services"

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
        case .addCenter(arName: let arName, enName: let enName, desccriptionen: let desccriptionen, arDescription: let arDescription, phone: let phone, address: let address, lat: let lat, lon: let lon):
            return .post
        case .addService(id: let id):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .center:
            return .requestPlain
        case .singleCenter:
            return .requestPlain
        case .searchInCenters(let key):
            return .requestPlain
        case .submitReview(let id,let review,let rate ):
            return .requestParmters(parms:["review":review,"rate":rate], encoding: JSONEncoding.prettyPrinted)
        case .listAllReviews:
            return .requestPlain
        case .makeFavorite(id: let id):
            return.requestPlain
        case .unFavorite:
            return .requestPlain
        case .addCenter(arName: let arName, enName: let enName, desccriptionen: let desccriptionen, arDescription: let arDescription, phone: let phone, address: let address, lat: let lat, lon: let lon):
            return .requestPlain
        case .addService(id: let id,title:let title):
            return .requestParmters(parms: ["title":title], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .center:
            return ["Authorization":HelperK.getUserToken(),"":""]
        case .singleCenter(let id):
            return ["Authorization":HelperK.getUserToken()]
        case .searchInCenters(let key):
            return ["Authorization":HelperK.getUserToken(),"Accept": "application/json"]
        case .submitReview:
            return ["Authorization":HelperK.getUserToken(),"Accept": "application/json","Content-Type": "application/json"]
                    case .listAllReviews:
            return ["Authorization":HelperK.getUserToken(),"Accept": "application/json"]
        case .makeFavorite(id: let id):
            return ["Authorization":HelperK.getUserToken(),"Accept": "application/json"]
        case .unFavorite(id: let id):
            return ["Authorization":HelperK.getUserToken()]
            
        case .addCenter(arName: let arName, enName: let enName, desccriptionen: let desccriptionen, arDescription: let arDescription, phone: let phone, address: let address, lat: let lat, lon: let lon):
            return ["Authorization":HelperK.getUserToken()]

        case .addService(id: let id, title: let title):
            return ["Authorization":HelperK.getUserToken(),"Content-Type": "application/json","accept": "application/json"]

        }
    }
    
    
}
