//
//  NotificationNetworking.swift
//  Dalel
//
//  Created by Shgardi on 25/02/2022.
//

import Foundation
import Alamofire
enum Notifications{
    case notification
}

extension Notifications : TargetType {
 
    
    var path: String {
        switch self {
        case .notification :
            return EndPoints.Notifications.notification.rawValue
    }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    
}
