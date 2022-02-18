//
//  BaseResponse.swift
//  Baladna
//
//  Created by sharaf on 17/12/2021.
//

import Foundation
struct BaseResponse<T:Codable>:Codable {
    var status:Bool?
    var payload:T?
    var message:String?
    enum CodingKeys:String,CodingKey {
        case status = "status"
        case payload = "payload"
        case message
    }
}

struct AnotherResponse<T:Codable>:Codable {
    var status:Bool?
    var payload:[T]?
    var message:String?
    var code:Int?
    enum CodingKeys:String,CodingKey {
        case status = "status"
        case payload = "payload"
        case message,code
    }
}
