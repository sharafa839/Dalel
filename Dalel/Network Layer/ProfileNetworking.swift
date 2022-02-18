//
//  ProfileNetworking.swift
//  Dalel
//
//  Created by Shgardi on 05/02/2022.
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
            return .patch

        case .myCenters:
            return .patch

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
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjRlMjE3YzYxNzYxYmNiNTc1MGJmN2JhNzNjNzBlMzI5MDQ4Y2Y0ODliMzg1NjkxZmY3YzU1MDZjY2MzODBiMjhhODY5NGFlZWE5OTY4MzAiLCJpYXQiOjE2NDUxNDQ0MDguNzgxODg4OTYxNzkxOTkyMTg3NSwibmJmIjoxNjQ1MTQ0NDA4Ljc4MTg5MzAxNDkwNzgzNjkxNDA2MjUsImV4cCI6MTY3NjY4MDQwOC43NjU4MTY5MjY5NTYxNzY3NTc4MTI1LCJzdWIiOiIxNTI2MzAzZS05MGUzLTQwZjItOGMwOS1jZGRkNWVmMWFjOGUiLCJzY29wZXMiOltdfQ.OqKPN76OlpSKjXQQ19_2lCRnUWcJAnjECPqOGA4i0Zu82XlrxgkLnVUXKpzQcP_tKHk8_qxZvIhi1j9wnJztkuKyujZlJWqPLTLETunBfdOCcfjgHYKCA_S0CVBVU1UXmzeH2pJ2pBul84RhmnOdNyRecTcOlgFZyrkjUs9VY4f1-EUnxH3V_Wvc09nJHl6cDilgQWDcVbDFgmfB1yyl7tmhAw4OiY-ZJr-M_slQteDEIb_8Rb17-PqyotX13Ty1_e64oQVSqXwFEoVJTER71bVJ06iQSLX5cGFVttuCnU86jUMo0xi-CTIbrMP_O8o_Yy_focExne8wR-lhnQ0MakEeR4rnGZoOe_bdjB3szfhP12YZcmPhxu-K-OivuWTWRuvkIweffi06gdCggbqHLwRecy8YnBrFACEqtxaSJqu3KFWpDdrQEv-d4sZ50E5dfIdv5OrTzgQRJfVGhOdQsOhTu700BUhnvNx-wSROIT_iOAQbOSXRDKji0LxuJ1grdT6TBLofUaJLYqfQlwh9DY-e7DGsfqfijLf-MITIRD0H-J___j-akWr7ukIzVrt674hgiWi_Z1_uhu7HS3naEbjyepGjPrEaaDwFrc04jj9BHNnHi3cKn-BmtRyJ0fES4_gVv-VW0Zk-35GZW1o9i3GxdsnSFZ9GZWM32fqgefs","Accept": "application/json","Content-Type": "application/json"]
        case .updateProfile(let fullName, let phone, let email):
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjRlMjE3YzYxNzYxYmNiNTc1MGJmN2JhNzNjNzBlMzI5MDQ4Y2Y0ODliMzg1NjkxZmY3YzU1MDZjY2MzODBiMjhhODY5NGFlZWE5OTY4MzAiLCJpYXQiOjE2NDUxNDQ0MDguNzgxODg4OTYxNzkxOTkyMTg3NSwibmJmIjoxNjQ1MTQ0NDA4Ljc4MTg5MzAxNDkwNzgzNjkxNDA2MjUsImV4cCI6MTY3NjY4MDQwOC43NjU4MTY5MjY5NTYxNzY3NTc4MTI1LCJzdWIiOiIxNTI2MzAzZS05MGUzLTQwZjItOGMwOS1jZGRkNWVmMWFjOGUiLCJzY29wZXMiOltdfQ.OqKPN76OlpSKjXQQ19_2lCRnUWcJAnjECPqOGA4i0Zu82XlrxgkLnVUXKpzQcP_tKHk8_qxZvIhi1j9wnJztkuKyujZlJWqPLTLETunBfdOCcfjgHYKCA_S0CVBVU1UXmzeH2pJ2pBul84RhmnOdNyRecTcOlgFZyrkjUs9VY4f1-EUnxH3V_Wvc09nJHl6cDilgQWDcVbDFgmfB1yyl7tmhAw4OiY-ZJr-M_slQteDEIb_8Rb17-PqyotX13Ty1_e64oQVSqXwFEoVJTER71bVJ06iQSLX5cGFVttuCnU86jUMo0xi-CTIbrMP_O8o_Yy_focExne8wR-lhnQ0MakEeR4rnGZoOe_bdjB3szfhP12YZcmPhxu-K-OivuWTWRuvkIweffi06gdCggbqHLwRecy8YnBrFACEqtxaSJqu3KFWpDdrQEv-d4sZ50E5dfIdv5OrTzgQRJfVGhOdQsOhTu700BUhnvNx-wSROIT_iOAQbOSXRDKji0LxuJ1grdT6TBLofUaJLYqfQlwh9DY-e7DGsfqfijLf-MITIRD0H-J___j-akWr7ukIzVrt674hgiWi_Z1_uhu7HS3naEbjyepGjPrEaaDwFrc04jj9BHNnHi3cKn-BmtRyJ0fES4_gVv-VW0Zk-35GZW1o9i3GxdsnSFZ9GZWM32fqgefs","Accept": "application/json","Content-Type": "application/json"]
        case .updateProfileLogo(let logo):
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjRlMjE3YzYxNzYxYmNiNTc1MGJmN2JhNzNjNzBlMzI5MDQ4Y2Y0ODliMzg1NjkxZmY3YzU1MDZjY2MzODBiMjhhODY5NGFlZWE5OTY4MzAiLCJpYXQiOjE2NDUxNDQ0MDguNzgxODg4OTYxNzkxOTkyMTg3NSwibmJmIjoxNjQ1MTQ0NDA4Ljc4MTg5MzAxNDkwNzgzNjkxNDA2MjUsImV4cCI6MTY3NjY4MDQwOC43NjU4MTY5MjY5NTYxNzY3NTc4MTI1LCJzdWIiOiIxNTI2MzAzZS05MGUzLTQwZjItOGMwOS1jZGRkNWVmMWFjOGUiLCJzY29wZXMiOltdfQ.OqKPN76OlpSKjXQQ19_2lCRnUWcJAnjECPqOGA4i0Zu82XlrxgkLnVUXKpzQcP_tKHk8_qxZvIhi1j9wnJztkuKyujZlJWqPLTLETunBfdOCcfjgHYKCA_S0CVBVU1UXmzeH2pJ2pBul84RhmnOdNyRecTcOlgFZyrkjUs9VY4f1-EUnxH3V_Wvc09nJHl6cDilgQWDcVbDFgmfB1yyl7tmhAw4OiY-ZJr-M_slQteDEIb_8Rb17-PqyotX13Ty1_e64oQVSqXwFEoVJTER71bVJ06iQSLX5cGFVttuCnU86jUMo0xi-CTIbrMP_O8o_Yy_focExne8wR-lhnQ0MakEeR4rnGZoOe_bdjB3szfhP12YZcmPhxu-K-OivuWTWRuvkIweffi06gdCggbqHLwRecy8YnBrFACEqtxaSJqu3KFWpDdrQEv-d4sZ50E5dfIdv5OrTzgQRJfVGhOdQsOhTu700BUhnvNx-wSROIT_iOAQbOSXRDKji0LxuJ1grdT6TBLofUaJLYqfQlwh9DY-e7DGsfqfijLf-MITIRD0H-J___j-akWr7ukIzVrt674hgiWi_Z1_uhu7HS3naEbjyepGjPrEaaDwFrc04jj9BHNnHi3cKn-BmtRyJ0fES4_gVv-VW0Zk-35GZW1o9i3GxdsnSFZ9GZWM32fqgefs","Content-type": "multipart/form-data"]
        case .updatePassword(let password, let confirmPassword):
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjRlMjE3YzYxNzYxYmNiNTc1MGJmN2JhNzNjNzBlMzI5MDQ4Y2Y0ODliMzg1NjkxZmY3YzU1MDZjY2MzODBiMjhhODY5NGFlZWE5OTY4MzAiLCJpYXQiOjE2NDUxNDQ0MDguNzgxODg4OTYxNzkxOTkyMTg3NSwibmJmIjoxNjQ1MTQ0NDA4Ljc4MTg5MzAxNDkwNzgzNjkxNDA2MjUsImV4cCI6MTY3NjY4MDQwOC43NjU4MTY5MjY5NTYxNzY3NTc4MTI1LCJzdWIiOiIxNTI2MzAzZS05MGUzLTQwZjItOGMwOS1jZGRkNWVmMWFjOGUiLCJzY29wZXMiOltdfQ.OqKPN76OlpSKjXQQ19_2lCRnUWcJAnjECPqOGA4i0Zu82XlrxgkLnVUXKpzQcP_tKHk8_qxZvIhi1j9wnJztkuKyujZlJWqPLTLETunBfdOCcfjgHYKCA_S0CVBVU1UXmzeH2pJ2pBul84RhmnOdNyRecTcOlgFZyrkjUs9VY4f1-EUnxH3V_Wvc09nJHl6cDilgQWDcVbDFgmfB1yyl7tmhAw4OiY-ZJr-M_slQteDEIb_8Rb17-PqyotX13Ty1_e64oQVSqXwFEoVJTER71bVJ06iQSLX5cGFVttuCnU86jUMo0xi-CTIbrMP_O8o_Yy_focExne8wR-lhnQ0MakEeR4rnGZoOe_bdjB3szfhP12YZcmPhxu-K-OivuWTWRuvkIweffi06gdCggbqHLwRecy8YnBrFACEqtxaSJqu3KFWpDdrQEv-d4sZ50E5dfIdv5OrTzgQRJfVGhOdQsOhTu700BUhnvNx-wSROIT_iOAQbOSXRDKji0LxuJ1grdT6TBLofUaJLYqfQlwh9DY-e7DGsfqfijLf-MITIRD0H-J___j-akWr7ukIzVrt674hgiWi_Z1_uhu7HS3naEbjyepGjPrEaaDwFrc04jj9BHNnHi3cKn-BmtRyJ0fES4_gVv-VW0Zk-35GZW1o9i3GxdsnSFZ9GZWM32fqgefs","Accept": "application/json","Content-Type": "application/json"]
        case .myFavorite:
            return [:]
        case .myCenters:
            return [:]
        }
    }
    
    
}

