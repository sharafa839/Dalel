//
//  ReviewModel.swift
//  Dalel
//
//  Created by  on 16/02/2022.
//

import Foundation
// MARK: - ReviewsModel
struct ReviewsModel: Codable {
    let payload: [ReviewsModelPayload]?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}

// MARK: - Payload
struct ReviewsModelPayload: Codable {
    let id, reviewableType, reviewableID: String?
    let rate: String?
    let review, userID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case reviewableType = "reviewable_type"
        case reviewableID = "reviewable_id"
        case rate, review
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
