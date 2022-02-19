//
//  GeneralApi.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import Foundation

protocol GeneralDataProtocol{
    func getGeneralData(compeletion:@escaping(_:Result<BaseResponse<GeneralModelPayload?>?,NSError>?,ErrorResponse?)->Void)
}

extension GeneralDataProtocol {
    private var general:GeneralDataRepo{
        return GeneralDataRepo()
    }
    func getGeneralData(compeletion:@escaping(_:Result<BaseResponse<GeneralModelPayload?>?,NSError>?,ErrorResponse?)->Void){
        general.fetchData(target: .GetGeneralData, responseClass: BaseResponse<GeneralModelPayload?>.self, compeletion: compeletion)
        
    }

}

class GeneralDataRepo : BaseApi<GeneralData>,GeneralDataProtocol{
  
    
    
}
