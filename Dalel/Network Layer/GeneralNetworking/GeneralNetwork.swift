//
//  GeneralNetwork.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import Foundation
import Alamofire
enum GeneralData{
    case GetGeneralData
    case FAQS
}

extension GeneralData : TargetType {
    var path: String {
        switch self {
        case .GetGeneralData:
            return EndPoints.General.general.rawValue
        case .FAQS:
            return EndPoints.FAQ.faqs.rawValue
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    
}
