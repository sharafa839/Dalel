//
//  CenterApi.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
import Alamofire
enum Centers{
    case center
    case singleCenter(id:String)
    case searchInCenters(key:String)
    case submitReview(id:String,review:String,rate:Int)
    case listAllReviews(id:String)
    case makeFavorite(id:String)
    case unFavorite(id:String)
    
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
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .center:
            return ["Authorization":"Bearer\(HelperK.getUserToken())","":""]
        case .singleCenter(let id):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
        case .searchInCenters(let key):
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZhNGU3ZjZlYjg4YWQyYmI1MmI4Zjk1NzI2NGRhMDU3NGQyN2I3ZjU1MmE3YTMzYTY0NmU5ZDNmZGMyOWQ2ZTJmZGE5NDQ1YWZlY2ZiNmYiLCJpYXQiOjE2NDUwNjMzMTQuNjk3OTg1ODg3NTI3NDY1ODIwMzEyNSwibmJmIjoxNjQ1MDYzMzE0LjY5Nzk4OTk0MDY0MzMxMDU0Njg3NSwiZXhwIjoxNjc2NTk5MzE0LjY4NDk3NzA1NDU5NTk0NzI2NTYyNSwic3ViIjoiMTUyNjMwM2UtOTBlMy00MGYyLThjMDktY2RkZDVlZjFhYzhlIiwic2NvcGVzIjpbXX0.ejYP2gwVcViXCIxhWxO-Oc0J2Jt1vb9J04v8cG_E2STNAgeUIUluEiG0o9APiCnId1zOrS2leBt9rsRfDB3ciyVv6yZev_VE5sLN6RlVzhh7IkhJvyMf2kCj3babVxod5m2FE2LvSYVvtsrDV6Txo11KKxiKctHqs1hbxNnG4Bw717VUH3xx1OcvAcQFKAvWajrDF6uypzEATlvy6HMsNWLARMR1NC0wR_tGqlHbb0nsu_6OsD9AHsA_Hnlles3M2FF9XorXPPeVfYZ73sjyC-3vU-4LNWGbcjJtO5B_A0P2FI0zl5d8Ie8RDdFmild_u6vvIUzLjlxxwB8dUvsZTK74H8ohT_7nh8W0ySDOl4j3itOM-3Md0VEh-wjtIRVugIxFHYTGBP4EZeY8r1YELSqqSy_7-uAMe0yYcNTB6GjKcQwaNewXjxUVFPcOheuO17CcgVdIEJXTtg6Aj6JBsQ0SgyiYLDYR2di_l6TyMIyiSqHJAdkZT5ZZnSnESmVUsP9rakwmk4qLgy8W2BeXsxtAJpsXtMh3I26tPnkW9wMwH9GbB7Qw187RKpiBR8C2BpG47bX3D4nQUp7eW34ZQByE7AWlAv4PE7TvJDsZIVC_p3Hrf5V32flI1FvpKIIVr5R_c6SgTPbBvCTyXlRLSSjRI48L2lnjftowtw3Kg44","Accept": "application/json"]
        case .submitReview:
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZhNGU3ZjZlYjg4YWQyYmI1MmI4Zjk1NzI2NGRhMDU3NGQyN2I3ZjU1MmE3YTMzYTY0NmU5ZDNmZGMyOWQ2ZTJmZGE5NDQ1YWZlY2ZiNmYiLCJpYXQiOjE2NDUwNjMzMTQuNjk3OTg1ODg3NTI3NDY1ODIwMzEyNSwibmJmIjoxNjQ1MDYzMzE0LjY5Nzk4OTk0MDY0MzMxMDU0Njg3NSwiZXhwIjoxNjc2NTk5MzE0LjY4NDk3NzA1NDU5NTk0NzI2NTYyNSwic3ViIjoiMTUyNjMwM2UtOTBlMy00MGYyLThjMDktY2RkZDVlZjFhYzhlIiwic2NvcGVzIjpbXX0.ejYP2gwVcViXCIxhWxO-Oc0J2Jt1vb9J04v8cG_E2STNAgeUIUluEiG0o9APiCnId1zOrS2leBt9rsRfDB3ciyVv6yZev_VE5sLN6RlVzhh7IkhJvyMf2kCj3babVxod5m2FE2LvSYVvtsrDV6Txo11KKxiKctHqs1hbxNnG4Bw717VUH3xx1OcvAcQFKAvWajrDF6uypzEATlvy6HMsNWLARMR1NC0wR_tGqlHbb0nsu_6OsD9AHsA_Hnlles3M2FF9XorXPPeVfYZ73sjyC-3vU-4LNWGbcjJtO5B_A0P2FI0zl5d8Ie8RDdFmild_u6vvIUzLjlxxwB8dUvsZTK74H8ohT_7nh8W0ySDOl4j3itOM-3Md0VEh-wjtIRVugIxFHYTGBP4EZeY8r1YELSqqSy_7-uAMe0yYcNTB6GjKcQwaNewXjxUVFPcOheuO17CcgVdIEJXTtg6Aj6JBsQ0SgyiYLDYR2di_l6TyMIyiSqHJAdkZT5ZZnSnESmVUsP9rakwmk4qLgy8W2BeXsxtAJpsXtMh3I26tPnkW9wMwH9GbB7Qw187RKpiBR8C2BpG47bX3D4nQUp7eW34ZQByE7AWlAv4PE7TvJDsZIVC_p3Hrf5V32","Accept": "application/json","Content-Type": "application/json"]
                    case .listAllReviews:
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZhNGU3ZjZlYjg4YWQyYmI1MmI4Zjk1NzI2NGRhMDU3NGQyN2I3ZjU1MmE3YTMzYTY0NmU5ZDNmZGMyOWQ2ZTJmZGE5NDQ1YWZlY2ZiNmYiLCJpYXQiOjE2NDUwNjMzMTQuNjk3OTg1ODg3NTI3NDY1ODIwMzEyNSwibmJmIjoxNjQ1MDYzMzE0LjY5Nzk4OTk0MDY0MzMxMDU0Njg3NSwiZXhwIjoxNjc2NTk5MzE0LjY4NDk3NzA1NDU5NTk0NzI2NTYyNSwic3ViIjoiMTUyNjMwM2UtOTBlMy00MGYyLThjMDktY2RkZDVlZjFhYzhlIiwic2NvcGVzIjpbXX0.ejYP2gwVcViXCIxhWxO-Oc0J2Jt1vb9J04v8cG_E2STNAgeUIUluEiG0o9APiCnId1zOrS2leBt9rsRfDB3ciyVv6yZev_VE5sLN6RlVzhh7IkhJvyMf2kCj3babVxod5m2FE2LvSYVvtsrDV6Txo11KKxiKctHqs1hbxNnG4Bw717VUH3xx1OcvAcQFKAvWajrDF6uypzEATlvy6HMsNWLARMR1NC0wR_tGqlHbb0nsu_6OsD9AHsA_Hnlles3M2FF9XorXPPeVfYZ73sjyC-3vU-4LNWGbcjJtO5B_A0P2FI0zl5d8Ie8RDdFmild_u6vvIUzLjlxxwB8dUvsZTK74H8ohT_7nh8W0ySDOl4j3itOM-3Md0VEh-wjtIRVugIxFHYTGBP4EZeY8r1YELSqqSy_7-uAMe0yYcNTB6GjKcQwaNewXjxUVFPcOheuO17CcgVdIEJXTtg6Aj6JBsQ0SgyiYLDYR2di_l6TyMIyiSqHJAdkZT5ZZnSnESmVUsP9rakwmk4qLgy8W2BeXsxtAJpsXtMh3I26tPnkW9wMwH9GbB7Qw187RKpiBR8C2BpG47bX3D4nQUp7eW34ZQByE7AWlAv4PE7TvJDsZIVC_p3Hrf5V32flI1FvpKIIVr5R_c6SgTPbBvCTyXlRLSSjRI48L2lnjftowtw3Kg44","Accept": "application/json"]
        case .makeFavorite(id: let id):
            return ["Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZhNGU3ZjZlYjg4YWQyYmI1MmI4Zjk1NzI2NGRhMDU3NGQyN2I3ZjU1MmE3YTMzYTY0NmU5ZDNmZGMyOWQ2ZTJmZGE5NDQ1YWZlY2ZiNmYiLCJpYXQiOjE2NDUwNjMzMTQuNjk3OTg1ODg3NTI3NDY1ODIwMzEyNSwibmJmIjoxNjQ1MDYzMzE0LjY5Nzk4OTk0MDY0MzMxMDU0Njg3NSwiZXhwIjoxNjc2NTk5MzE0LjY4NDk3NzA1NDU5NTk0NzI2NTYyNSwic3ViIjoiMTUyNjMwM2UtOTBlMy00MGYyLThjMDktY2RkZDVlZjFhYzhlIiwic2NvcGVzIjpbXX0.ejYP2gwVcViXCIxhWxO-Oc0J2Jt1vb9J04v8cG_E2STNAgeUIUluEiG0o9APiCnId1zOrS2leBt9rsRfDB3ciyVv6yZev_VE5sLN6RlVzhh7IkhJvyMf2kCj3babVxod5m2FE2LvSYVvtsrDV6Txo11KKxiKctHqs1hbxNnG4Bw717VUH3xx1OcvAcQFKAvWajrDF6uypzEATlvy6HMsNWLARMR1NC0wR_tGqlHbb0nsu_6OsD9AHsA_Hnlles3M2FF9XorXPPeVfYZ73sjyC-3vU-4LNWGbcjJtO5B_A0P2FI0zl5d8Ie8RDdFmild_u6vvIUzLjlxxwB8dUvsZTK74H8ohT_7nh8W0ySDOl4j3itOM-3Md0VEh-wjtIRVugIxFHYTGBP4EZeY8r1YELSqqSy_7-uAMe0yYcNTB6GjKcQwaNewXjxUVFPcOheuO17CcgVdIEJXTtg6Aj6JBsQ0SgyiYLDYR2di_l6TyMIyiSqHJAdkZT5ZZnSnESmVUsP9rakwmk4qLgy8W2BeXsxtAJpsXtMh3I26tPnkW9wMwH9GbB7Qw187RKpiBR8C2BpG47bX3D4nQUp7eW34ZQByE7AWlAv4PE7TvJDsZIVC_p3Hrf5V32flI1FvpKIIVr5R_c6SgTPbBvCTyXlRLSSjRI48L2lnjftowtw3Kg44","Accept": "application/json"]
        case .unFavorite(id: let id):
            return ["Authorization":"Bearer\(HelperK.getUserToken())"]
            
        }
    }
    
    
}
