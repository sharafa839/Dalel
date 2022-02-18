//
//  ProfileModel.swift
//  Dalel
//
//  Created by Shgardi on 17/02/2022.
//

import Foundation
struct ProfileModel: Codable {
    let payload: ProfileModelPayload?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}

// MARK: - Payload
struct ProfileModelPayload: Codable {
    let id, fullName, email: String?
    let emailVerifiedAt: String?
    let phone, phoneCode: String?
    let lang: String?
    let type, status: String?
    let firebaseCloudMessagingToken, deletedAt: String?
    let createdAt, updatedAt: String?
    let allUserMedia: AllUserMedia?
    let logoURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case emailVerifiedAt = "email_verified_at"
        case phone
        case phoneCode = "phone_code"
        case lang, type, status
        case firebaseCloudMessagingToken = "firebase_cloud_messaging_token"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case allUserMedia
        case logoURL = "logo_url"
    }
}

// MARK: - AllUserMedia
struct AllUserMedia: Codable {
    let logo: String?
}
