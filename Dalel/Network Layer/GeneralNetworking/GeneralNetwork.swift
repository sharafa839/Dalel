//
//  GeneralNetwork.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import Foundation
import Alamofire
enum GeneralData{
    case GetGeneralData
}

extension GeneralData : TargetType {
    var path: String {
        switch self {
        case .GetGeneralData:
            return EndPoints.General.general.rawValue
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    
}
