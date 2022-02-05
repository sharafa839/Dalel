//
//  UsersNetworking.swift
//  Baladna
//
//  Created by sharaf on 31/10/2021.
//

import Foundation
import Alamofire
enum AuthNetworking {
    //cases with function that i use in Auth Module
    case Register(name:String,email:String,password:String,phone:String,phoneCode:String,type:String)
    case login(phone:String,password:String)
    case loginByEmail(email:String,password:String)
    case logout
    
}
extension AuthNetworking:TargetType{

    var baseURL: String {
        switch self {
        
        default:
            return "https://bladuna.com/api/"
        }
    }
    
    var path: String {
        switch self {
        case .Register(let name, let email, let password, let phone, let phoneCode, let type):
            return EndPoints.Auth.register
        case .login(let phone, let password):
            return EndPoints.Auth.login.
        case .loginByEmail(let email, let password):
            return EndPoints.Auth.loginByEmail
        case .logout:
            return EndPoints.Auth.logout
        }
    }
    
    var method: HTTPMethod {
        switch self {
        
        case .createUser,.logout,.login,.loginByEmail:
            return .post
        }
    }
    
    var task: Task {
        switch self {
             case .createUser(let name , let email , let password , let phone,let phoneCode,let type):
                 return .requestParmters(parms: [
                     "full_name": name,
                     "email": email,
                     "password": password,
                     "phone": phone,
                     "phone_code": phoneCode,
                     "type": type
                 ]), encoding:JSONEncoding.prettyPrinted)
        case .login(let phone, let password):
            return .requestParmters(parms: ["phone":phone,"password":password], encoding: JSONEncoding)
        case .loginByEmail(let email, let password):
            return .requestParmters(parms: ["email":phone,"password":password], encoding: JSONEncoding)
        case .logout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
       
    }
    
    }
}
