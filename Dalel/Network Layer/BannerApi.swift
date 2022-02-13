//
//  BannerApi.swift
//  Dalel
//
//  Created by Shgardi on 12/02/2022.
//

import Foundation
protocol BannerProtocol{
    func getBanners(compeletion:@escaping(_:Result<BaseResponse<BannerModel>?,NSError>?,ErrorResponse?)->Void)
}

extension BannerProtocol {
    private var banners:BannerRepo{
        return BannerRepo()
    }
    func getBanners(compeletion:@escaping(_:Result<BaseResponse<BannerModel>?,NSError>?,ErrorResponse?)->Void){
        banners.fetchData(target: .banner, responseClass: BaseResponse<BannerModel>.self, compeletion: compeletion)
        
    }

}

class BannerRepo : BaseApi<Banner>,BannerProtocol{
    
}
