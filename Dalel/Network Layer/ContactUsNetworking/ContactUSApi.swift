//
//  ContactUSApi.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import Foundation
protocol ContactUSProtocol{
    func contactus(messgae:String,name:String,email:String,phone:String,compeletion:@escaping(_:Result<BaseResponse<JSONAny>?,NSError>?,ErrorResponse?)->Void)
}

extension ContactUSProtocol {
    private var con:ContactUsRepo{
        return ContactUsRepo()
    }
    func contactus(messgae:String,name:String,email:String,phone:String,compeletion:@escaping(_:Result<BaseResponse<JSONAny>?,NSError>?,ErrorResponse?)->Void){
        con.fetchData(target: .contact(name: name, email: email, phone: phone, messge: messgae), responseClass: BaseResponse<JSONAny>.self, compeletion: compeletion)
    }
    
    
}
class ContactUsRepo : BaseApi<ContactUs>,ContactUSProtocol{
  
    
    
}
