//
//  CenterProtocol.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
import SwiftUI
protocol CenterProtocol {
    func centers(compeletion:@escaping(_:Result<BaseResponse<[CenterModelPayload]>?,NSError>?,ErrorResponse?)->Void)
    func singleCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<SingleCenterPayload>?,NSError>?,ErrorResponse?)->Void)
    func getReviews(id:String,compeletion:@escaping(_:Result<BaseResponse<[ReviewsModelPayload]>?,NSError>?,ErrorResponse?)->Void)
    func makeFavorite(id:String,compeletion:@escaping(_:Result<BaseResponse<MakeFavoriteModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func makeUnFavorite(id:String,compeletion:@escaping(_:Result<BaseResponse<MakeFavoriteModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func submitReview(id:String,review:String,rate:
                      Int,compeletion:@escaping(_:Result<BaseResponse<JSONAny>?,NSError>?,ErrorResponse?)->Void)
    func searchInCenters(keyword:String,compeletion:@escaping(_:Result<BaseResponse<[SearchModelPayload]>?,NSError>?,ErrorResponse?)->Void)
    func addCenter(image:UIImage,nameAr:String,nameEn:String,descriptionAr:String,descriptionEn:String,phone:String,address:String,lat:String,lon:String,category:String,compeletion:@escaping(_:Result<BaseResponse<AddCenterModelPayload>?,NSError>?,ErrorResponse?)->Void)
    
    func addService(id:String,service:String,compeletion:@escaping(_:Result<BaseResponse<ServiceModelPayload>?,NSError>?,ErrorResponse?)->Void)
    func updateCenter(image:UIImage,nameAr:String,nameEn:String,descriptionAr:String,descriptionEn:String,phone:String,address:String,lat:String,lon:String,category:String,compeletion:@escaping(_:Result<BaseResponse<AddCenterModelPayload>?,NSError>?,ErrorResponse?)->Void)

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
    
    func submitReview(id:String,review:String,rate:
                      Int,compeletion:@escaping(_:Result<BaseResponse<JSONAny>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .submitReview(id: id, review: review, rate: rate), responseClass: BaseResponse<JSONAny>.self, compeletion: compeletion)
    }
    
    func searchInCenters(keyword:String,compeletion:@escaping(_:Result<BaseResponse<[SearchModelPayload]>?,NSError>?,ErrorResponse?)->Void){
        center.fetchData(target: .searchInCenters(key: keyword), responseClass: BaseResponse<[SearchModelPayload]>.self, compeletion: compeletion)
    }
    
    func addCenter(image:UIImage,nameAr:String,nameEn:String,descriptionAr:String,descriptionEn:String,phone:String,address:String,lat:String,lon:String,category:String,compeletion:@escaping(_:Result<BaseResponse<AddCenterModelPayload>?,NSError>?,ErrorResponse?)->Void){
    center.uploadMultipart(parmss: ["en_name":nameEn,"ar_name":nameAr,"en_description":descriptionEn,"ar_description":descriptionAr,"phone":phone,"address":address,"latitude":lat,"longitude":lon,"category_id":category], name: "images[]", image:image, target: .addCenter(arName: "", enName: "", desccriptionen: "", arDescription: "", phone: "", address: "", lat: "", lon: ""), responseClass: BaseResponse<AddCenterModelPayload>.self, compeletion: compeletion)
    }

    func addService(id:String,service:String,compeletion:@escaping(_:Result<BaseResponse<ServiceModelPayload>?,NSError>?,ErrorResponse?)->Void){
        
        center.fetchData(target: .addService(id: id, title: service), responseClass: BaseResponse<ServiceModelPayload>.self, compeletion: compeletion)
    }
    func updateCenter(image:UIImage,nameAr:String,nameEn:String,descriptionAr:String,descriptionEn:String,phone:String,address:String,lat:String,lon:String,category:String,compeletion:@escaping(_:Result<BaseResponse<AddCenterModelPayload>?,NSError>?,ErrorResponse?)->Void){
        center.uploadMultipart(parmss: ["en_name":nameEn,"ar_name":nameAr,"en_description":descriptionEn,"ar_description":descriptionAr,"phone":phone,"address":address,"latitude":lat,"longitude":lon,"category_id":category], name: "images[]", image:image, target: .addCenter(arName: "", enName: "", desccriptionen: "", arDescription: "", phone: "", address: "", lat: "", lon: ""), responseClass: BaseResponse<AddCenterModelPayload>.self, compeletion: compeletion)
    }
    
}
class CenterRepo:BaseApi<Centers>, AuthenticationProtocol{
    
}
