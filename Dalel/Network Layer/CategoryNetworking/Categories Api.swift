//
//  Categories Api.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
protocol CategoriesProtocol{
    func categories(compeletion:@escaping(_:Result<BaseResponse<CategoriesModel>?,NSError>?,ErrorResponse?)->Void)
    func singleCategory(id:String,compeletion:@escaping(_:Result<BaseResponse<CategoriesModel>?,NSError>?,ErrorResponse?)->Void)
    func singleCategoryCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<CategoriesModel>?,NSError>?,ErrorResponse?)->Void)
}

extension CategoriesProtocol {
    private var category : CategoriesRepo{
        return CategoriesRepo()
    }
    func categories(compeletion:@escaping(_:Result<BaseResponse<CategoriesModel>?,NSError>?,ErrorResponse?)->Void){
        category.fetchData(target: .categories, responseClass: BaseResponse<CategoriesModel>.self, compeletion: compeletion)
    }
    func singleCategory(id:String,compeletion:@escaping(_:Result<BaseResponse<CategoriesModel>?,NSError>?,ErrorResponse?)->Void){
        category.fetchData(target: .singleCategories(id: id), responseClass: BaseResponse<CategoriesModel>.self, compeletion: compeletion)
    }
    func singleCategoryCenter(id:String,compeletion:@escaping(_:Result<BaseResponse<CategoriesModel>?,NSError>?,ErrorResponse?)->Void){
        category.fetchData(target: .singleCategoriesCenterI(id: id), responseClass: BaseResponse<CategoriesModel>.self, compeletion: compeletion)
    }
    

}
class CategoriesRepo:BaseApi<Categories>,CategoriesProtocol{
    
}
