//
//  EndPoints.swift
//  Dalel
//
//  Created by Shgardi on 05/02/2022.
//

import Foundation
enum EndPoints {
    enum Auth:String {
        case register = "/register"
        case login = "/login"
        case loginByEmail = "/login?login_by_email"
        case logout = "/logout"
    }
    enum ProfilePath:String{
        case profile = "/profile"
        case getCenters = "/profile/show/my-centers"
        case updateProfile = "/profile/update"
        case updatePassword = "/profile/update/password"
        case updateFCMToken = "/profile/update/fcm_token"
        case updateProfileLogo = "/profile/update/logo"
        case favorite = "/profile/show/my-favorites"
    }
    enum Banners:String {
        case listAllBanners = "/banners"
    }
    enum Categories : String {
        case Categories = "/categories"
      
    }
    enum Centers : String {
        case centers = "/centers/"
        
    }
    enum General : String {
        case general = "/general"
    }
    
    enum FAQ : String {
        case faqs  = "/faqs"
    }
    
    enum Contact : String {
        case contact  = "/contacts"
    }
}
