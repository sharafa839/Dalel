//
//  ServiceModel.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import Foundation

// MARK: - ServiceModel
struct ServiceModel: Codable {
    let payload: ServiceModelPayload?
    let status: Bool?
    let code: Int?
    let messages: String?
}

// MARK: - Payload
struct ServiceModelPayload: Codable {
    let title, centerID, id, updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case title
        case centerID = "center_id"
        case id
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
