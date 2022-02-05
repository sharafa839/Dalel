//
//  LoginModel.swift
//  Dalel
//
//  Created by Shgardi on 05/02/2022.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    var payload: Payload?
    var status: Bool?
    var code: Int?
    var messages: String?
}

// MARK: - Payload
struct Payload: Codable {
    var userID: String?
    var userLogo: String?
    var userType, tokenType, token, tokenExpiresAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userLogo = "user_logo"
        case userType = "user_type"
        case tokenType = "token_type"
        case token
        case tokenExpiresAt = "token_expires_at"
    }
}
