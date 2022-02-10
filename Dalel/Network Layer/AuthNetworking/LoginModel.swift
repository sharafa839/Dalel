//
//  LoginModel.swift
//  Dalel
//
//  Created by Shgardi on 10/02/2022.
//

import Foundation
struct LoginModel: Codable {
    var payload: LoginPayload?
    var status: Bool?
    var code: Int?
    var messages: JSONNull?
}

// MARK: - Payload
struct LoginPayload: Codable {
    var userID, userLogo, userType, tokenType: String?
    var token, tokenExpiresAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userLogo = "user_logo"
        case userType = "user_type"
        case tokenType = "token_type"
        case token
        case tokenExpiresAt = "token_expires_at"
    }
}
