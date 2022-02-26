//
//  AddCenterModel.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addCenterModel = try? newJSONDecoder().decode(AddCenterModel.self, from: jsonData)

import Foundation

// MARK: - AddCenterModel
struct AddCenterModel: Codable {
    let payload: AddCenterModelPayload?
    let status: Bool?
    let code: Int?
    let messages: String?
}

// MARK: - Payload
struct AddCenterModelPayload: Codable {
    let enName, arName, enDescription, arDescription: String?
    let address, phone, categoryID: String?
    let facebook, twitter, instagram, snapchat: String?
    let youtube, linkedin: String?
    let creatorID, id, updatedAt, createdAt: String?
    let nameByLang, descriptionByLang, mainMediaURL: String?
    let mediaLinks: [MediaLink]?
    let isFavorited: Bool?

    enum CodingKeys: String, CodingKey {
        case enName = "en_name"
        case arName = "ar_name"
        case enDescription = "en_description"
        case arDescription = "ar_description"
        case address, phone
        case categoryID = "category_id"
        case facebook, twitter, instagram, snapchat, youtube, linkedin
        case creatorID = "creator_id"
        case id
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case nameByLang = "name_by_lang"
        case descriptionByLang = "description_by_lang"
        case mainMediaURL = "main_media_url"
        case mediaLinks = "media_links"
        case isFavorited = "is_favorited"
    }
}

