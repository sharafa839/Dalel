//
//  ContactNetworking.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import Foundation
import Alamofire
enum ContactUs{
    case contact(name:String,email:String,phone:String,messge:String)
}

extension ContactUs:TargetType {
    var path: String {
        switch self {
        case .contact(let name, let email, let phone, let messge):
            return EndPoints.Contact.contact.rawValue

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .contact(let name, let email, let phone, let messge):
            return .post

        }
    }
    
    var task: Task {
        switch self {
        case .contact(let name, let email, let phone, let messge):
            return .requestParmters(parms: ["name":name,"email":email,"phone":phone,"message":messge], encoding: JSONEncoding.default)

        }
    }
    
    
}
