//
//  ProfileApi.swift
//  Dalel
//
//  Created by Shgardi on 05/02/2022.
//

import Foundation
import UIKit
protocol ProfileProtocol {
    func getProfile(compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func updateProfile(name:String,email:String,phone:String,compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func updateProfileLogo(logo:UIImage,compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func updateProfilepassword(password:String,confirmPassword:String,compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void)

    func getFavorites(compeletion:@escaping(_:Result<BaseResponse<[FavoriteModelPayload]>?,NSError>?,ErrorResponse?)->Void)

}

extension ProfileProtocol {
    private var profile : ProfileRepo{
        return ProfileRepo()
    }
    func getProfile(compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void){
        profile.fetchData(target: .profile, responseClass: BaseResponse<ProfileModelPayload>.self, compeletion: compeletion)
    }
    
    func updateProfile(name:String,email:String,phone:String,compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void){
        profile.fetchData(target: .updateProfile(fullName: name, phone: phone, email: email), responseClass: BaseResponse<ProfileModelPayload>.self, compeletion: compeletion)

    }
    func updateProfileLogo(logo:UIImage,compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void){
        profile.uploadMultipart(image: logo, target: .updateProfileLogo(logo: logo), responseClass: BaseResponse<ProfileModelPayload>.self, compeletion: compeletion)
    }
    
    func updateProfilepassword(password:String,confirmPassword:String,compeletion:@escaping(_:Result<BaseResponse<ProfileModelPayload>?,NSError>?,ErrorResponse?)->Void){
        profile.fetchData(target: .updatePassword(password: password, confirmPassword: confirmPassword), responseClass: BaseResponse<ProfileModelPayload>.self, compeletion: compeletion)
    }

    func getFavorites(compeletion:@escaping(_:Result<BaseResponse<[FavoriteModelPayload]>?,NSError>?,ErrorResponse?)->Void){
        profile.fetchData(target: .myFavorite, responseClass: BaseResponse<[FavoriteModelPayload]>.self, compeletion: compeletion)
    }
    
}


class ProfileRepo:BaseApi<Profile>,ProfileProtocol{
    
        
    
}
