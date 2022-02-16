//
//  CenterProtocol.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
protocol CenterProtocol {
    func centers(compeletion:@escaping(_:Result<BaseResponse<[CenterModelPayload]>?,NSError>?,ErrorResponse?)->Void)
    func singleCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<SingleCenterPayload>?,NSError>?,ErrorResponse?)->Void)
    func getReviews(id:String,compeletion:@escaping(_:Result<BaseResponse<[ReviewsModelPayload]>?,NSError>?,ErrorResponse?)->Void)
    func makeFavorite(id:String,compeletion:@escaping(_:Result<BaseResponse<MakeFavoriteModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func makeUnFavorite(id:String,compeletion:@escaping(_:Result<BaseResponse<MakeFavoriteModelPayload>?,NSError>?,ErrorResponse?)->Void)

}

extension CenterProtocol {
    
    private var center : CenterRepo {
        return CenterRepo()
    }
    
    func centers(compeletion:@escaping(_:Result<BaseResponse<[CenterModelPayload]>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .center, responseClass: BaseResponse<[CenterModelPayload]>.self, compeletion: compeletion)
        
    }
    
    func singleCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<SingleCenterPayload>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .singleCenter(id: id), responseClass: BaseResponse<SingleCenterPayload>.self, compeletion: compeletion)
    }
    func getReviews(id:String,compeletion:@escaping(_:Result<BaseResponse<[ReviewsModelPayload]>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .listAllReviews(id: id), responseClass: BaseResponse<[ReviewsModelPayload]>.self, compeletion: compeletion)
    }
    func makeFavorite(id:String,compeletion:@escaping(_:Result<BaseResponse<MakeFavoriteModelPayload>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .makeFavorite(id: id), responseClass: BaseResponse<MakeFavoriteModelPayload>.self, compeletion: compeletion)
    }
    func makeUnFavorite(id:String,compeletion:@escaping(_:Result<BaseResponse<MakeFavoriteModelPayload>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .makeFavorite(id: id), responseClass: BaseResponse<MakeFavoriteModelPayload>.self, compeletion: compeletion)

    }
    
}
class CenterRepo:BaseApi<Centers>, AuthenticationProtocol{
    
}
