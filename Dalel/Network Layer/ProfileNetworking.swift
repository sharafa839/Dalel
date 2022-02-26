//
//  ProfileNetworking.swift
//  Dalel
//
//  Created by  on 05/02/2022.
//

import Foundation
import Alamofire
import UIKit
import Moya
enum Profile {
    case profile
    case updateProfile(fullName:String,phone:String,email:String)
    case updateProfileLogo(logo:UIImage)
    case updatePassword(password:String,confirmPassword:String)
    case myFavorite
    case myCenters
    
}

extension Profile : TargetType {
    var baseURL:String{
        return "https://Dalil-taelim.com/api"
    }
    
    var path: String {
        switch self {
        case .profile:
            return EndPoints.ProfilePath.profile.rawValue
        case .updateProfile(let fullName, let phone, let email):
            return EndPoints.ProfilePath.updateProfile.rawValue
        case .updateProfileLogo(let logo):
            return EndPoints.ProfilePath.updateProfileLogo.rawValue
        case .updatePassword(let password, let confirmPassword):
            return EndPoints.ProfilePath.updatePassword.rawValue
        case .myFavorite:
            return EndPoints.ProfilePath.favorite.rawValue
        case .myCenters:
            return EndPoints.ProfilePath.getCenters.rawValue
        }    }
    
    var method: HTTPMethod {
        switch self {
            
        case .profile:
            return .get
        case .updateProfile:
            return .patch
        case .updateProfileLogo:
            return .post

        case .updatePassword:
            return .patch

        case .myFavorite:
            return .get

        case .myCenters:
            return .get

        }
    }
    
    var task: Task {
        switch self {
            
        case .profile:
            return .requestPlain
        case .updateProfile(let fullName,let phone,let email):
               return .requestParmters(parms: ["full_name":fullName,"email":email,"phone":phone], encoding: JSONEncoding.prettyPrinted)

        case .updatePassword(let password,let confirmPassword):
               return .requestParmters(parms: ["password":password,"password_confirmation":confirmPassword], encoding: JSONEncoding.prettyPrinted)
        case .myFavorite:
            return .requestPlain
        case .myCenters:
            return .requestPlain
        case .updateProfileLogo( let logo):
            return  .requestPlain
        }
    }
    
    var headers: [String : String]?{
        switch self {
        case .profile:
            return ["Authorization": HelperK.getUserToken(),"Accept": "application/json","Content-Type": "application/json"]
        case .updateProfile(let fullName, let phone, let email):
            return ["Authorization": HelperK.getUserToken(),"Accept": "application/json","Content-Type": "application/json"]
        case .updateProfileLogo(let logo):
            return ["Authorization": HelperK.getUserToken(),"Content-type": "multipart/form-data"]
        case .updatePassword(let password, let confirmPassword):
            return ["Authorization":HelperK.getUserToken(),"Accept": "application/json","Content-Type": "application/json"]
        case .myFavorite:
            return ["Authorization": HelperK.getUserToken(),"Accept": "application/json","Content-Type": "application/json"]
        case .myCenters:
              return ["Authorization":HelperK.getUserToken(),"Accept": "application/json","Content-Type": "application/json"]
        }
    }
    
    
}

