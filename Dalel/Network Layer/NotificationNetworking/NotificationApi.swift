//
//  NotificationApi.swift
//  Dalel
//
//  Created by Shgardi on 25/02/2022.
//

import Foundation
protocol NotificationProtocol{
    func getNotifications(compeletion:@escaping(_:Result<BaseResponse<[NotificationModelPayload]?>?,NSError>?,ErrorResponse?)->Void)

}

extension NotificationProtocol{
    private var notification:NotificationRepo{
        return NotificationRepo()
    }
    
    func getNotifications(compeletion:@escaping(_:Result<BaseResponse<[NotificationModelPayload]?>?,NSError>?,ErrorResponse?)->Void){
        notification.fetchData(target: .notification, responseClass: BaseResponse<[NotificationModelPayload]?>.self, compeletion: compeletion)
    }
    

}
class NotificationRepo : BaseApi<Notifications>,NotificationProtocol{
  
    
    
}
