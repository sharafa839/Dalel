//
//  AuthApi.swift
//  Baladna
//
//  Created by sharaf on 31/10/2021.
//

import Foundation
protocol AuthenticationProtocol {
    func register(data:Data?,name: String, email: String, password: String, phone: String,phoneCode:String, type: String,compeletion : @escaping(Result<BaseResponse<LoginPayload>?,NSError>,ErrorResponse?)->Void)
    func login(phone:String,password:String,compeletion:@escaping(Result<BaseResponse<LoginPayload>?,NSError>,ErrorResponse?)->Void)
    
    func logout(compeletion:@escaping(Result<BaseResponse<LogoutModel>?,NSError>,ErrorResponse?)->Void)
    func loginByEmail(email:String,password:String,compeletion:@escaping(Result<BaseResponse<LoginPayload>?,NSError>,ErrorResponse?)->Void)
}
extension AuthenticationProtocol  {
    private var auth : AuthRepo {
        AuthRepo()
    }
    func register(data:Data?,name: String, email: String, password: String, phone: String,phoneCode:String, type: String,compeletion : @escaping(Result<BaseResponse<LoginPayload>?,NSError>,ErrorResponse?)->Void){
        if data != nil {
        auth.uploadPdf(parmss: [
            "full_name": name,
            "email": email,
            "password": password,
            "phone": phone,
            "phone_code": phoneCode,
            "type": type
        ], name: "center_details_in_file", image: data!, target: .register(name: name, email: email, password: password, phone: phone, phoneCode: phoneCode, type: type), responseClass: BaseResponse<LoginPayload>.self, compeletion:compeletion)
        }else{
            auth.fetchData(target: .register(name: name, email: email, password: password, phone: phone, phoneCode: phoneCode, type: type), responseClass: BaseResponse<LoginPayload>.self, compeletion: compeletion)
        }
        
    }
    
    func login(phone:String,password:String,compeletion:@escaping(Result<BaseResponse<LoginPayload>?,NSError>,ErrorResponse?)->Void){
        auth.fetchData(target: .login(phone: phone, password: password), responseClass: BaseResponse<LoginPayload>.self, compeletion:compeletion)
    }
    
    func logout(compeletion:@escaping(Result<BaseResponse<LogoutModel>?,NSError>,ErrorResponse?)->Void){
        auth.fetchData(target: .logout, responseClass: BaseResponse<LogoutModel>.self, compeletion: compeletion)
    }
    
    func loginByEmail(email:String,password:String,compeletion:@escaping(Result<BaseResponse<LoginPayload>?,NSError>,ErrorResponse?)->Void){
        auth.fetchData(target: .loginByEmail(email: email, password: password), responseClass: BaseResponse<LoginPayload>.self, compeletion:compeletion )
    }
}

class AuthRepo:BaseApi<AuthNetworking>, AuthenticationProtocol{
    
}
