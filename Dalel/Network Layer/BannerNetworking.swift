//
//  BannerNetworking.swift
//  Dalel
//
//  Created by Shgardi on 12/02/2022.
//

import Foundation
import Alamofire
enum Banner{
    case banner
}
extension Banner :TargetType{
    var baseURL: String {
        switch self {
        case .banner:
            return "https://Dalil-taelim.com/api"
        }
    }
    
    var path: String {
        switch self {
        case .banner:
            return EndPoints.Banners.listAllBanners.rawValue

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .banner:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
