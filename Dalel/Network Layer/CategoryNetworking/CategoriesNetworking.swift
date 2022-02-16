//
//  CategoriesNetworking.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
import Alamofire
enum Categories {
    case categories
    case singleCategories(id:String)
    case singleCategoriesCenterI(id:String)
}
extension Categories : TargetType {
    var baseURL: String {
        switch self{
        default :
            return "https://Dalil-taelim.com/api"

        }
        
    }
    
    var path: String {
        switch self {
        case .categories :
            return "/categories"
        case .singleCategories(let id):
            return "/categories\(id)"

        case .singleCategoriesCenterI(let id):
            return "/categories/\(id)/centers"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .categories,.singleCategories,.singleCategoriesCenterI:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case  .singleCategoriesCenterI: return .requestPlain
        case .categories: return .requestPlain
        case .singleCategories: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
