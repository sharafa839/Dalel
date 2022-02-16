//
//  BannerModel.swift
//  Dalel
//
//  Created by Shgardi on 12/02/2022.
//

import Foundation

// MARK: - CenterModel
struct BannerModel: Codable {
    let payload: [BannerPayload]?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}

// MARK: - Payload
struct BannerPayload: Codable {
    let id: String?
    let arTitle, enTitle: String?
    let url: String?
    let status: String?
    let categoryID: String?
    let creatorID, createdAt, updatedAt: String?
    let titleByLang: String?
    let mainMediaURL: String?
    let randKey: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case arTitle = "ar_title"
        case enTitle = "en_title"
        case url, status
        case categoryID = "category_id"
        case creatorID = "creator_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case titleByLang = "title_by_lang"
        case mainMediaURL = "main_media_url"
        case randKey = "rand_key"
    }
}

