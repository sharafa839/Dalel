//
//  Categories Api.swift
//  Dalel
//
//  Created by  on 11/02/2022.
//

import Foundation
protocol CategoriesProtocol{
    func categories(compeletion:@escaping(_:Result<BaseResponse<[CategoriesModelPayload]?>?,NSError>?,ErrorResponse?)->Void)
    func singleCategory(id:String,compeletion:@escaping(_:Result<BaseResponse<[CategoriesModelPayload]?>?,NSError>?,ErrorResponse?)->Void)
    func singleCategoryCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<[CagtegoryCenterModelPayload]?>?,NSError>?,ErrorResponse?)->Void)
}

extension CategoriesProtocol {
    private var category : CategoriesRepo{
        return CategoriesRepo()
    }
    func categories(compeletion:@escaping(_:Result<BaseResponse<[CategoriesModelPayload]?>?,NSError>?,ErrorResponse?)->Void){
        category.fetchData(target: .categories, responseClass: BaseResponse<[CategoriesModelPayload]?>.self, compeletion: compeletion)
    }
    func singleCategory(id:String,compeletion:@escaping(_:Result<BaseResponse<[CategoriesModelPayload]?>?,NSError>?,ErrorResponse?)->Void){
        category.fetchData(target: .singleCategories(id: id), responseClass: BaseResponse<[CategoriesModelPayload]?>.self, compeletion: compeletion)
    }
    func singleCategoryCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<[CagtegoryCenterModelPayload]?>?,NSError>?,ErrorResponse?)->Void){
        category.fetchData(target: .singleCategoriesCenterI(id: id), responseClass: BaseResponse<[CagtegoryCenterModelPayload]?>.self, compeletion: compeletion)
    }
    

}
class CategoriesRepo:BaseApi<Categories>,CategoriesProtocol{
    
}
