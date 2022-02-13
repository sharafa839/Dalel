//
//  CenterProtocol.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
protocol CenterProtocol {
    func centers(compeletion:@escaping(_:Result<BaseResponse<CenterModel>?,NSError>?,ErrorResponse?)->Void)
    func singleCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<CenterModel>?,NSError>?,ErrorResponse?)->Void)
    
}

extension CenterProtocol {
    
    private var center : CenterRepo {
        return CenterRepo()
    }
    
    func centers(compeletion:@escaping(_:Result<BaseResponse<CenterModel>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .center, responseClass: BaseResponse<CenterModel>.self, compeletion: compeletion)
        
    }
    
    func singleCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<CenterModel>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .singleCenter(id: id), responseClass: BaseResponse<CenterModel>.self, compeletion: compeletion)
    }
    
    
}
class CenterRepo:BaseApi<Centers>, AuthenticationProtocol{
    
}
