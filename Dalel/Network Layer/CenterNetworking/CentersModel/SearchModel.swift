//
//  SearchModel.swift
//  Dalel
//
//  Created by  on 17/02/2022.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let payload: [SearchModelPayload]?
    let links: Links?
    let meta: Meta?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}

// MARK: - Payload
struct SearchModelPayload: Codable {
    let id, enName, arName, enDescription: String?
    let arDescription, phone, address, viewsCount: String?
    let averageRate, categoryID, creatorID: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?
    let facebook, twitter, linkedin, instagram: String?
    let snapchat, youtube: String?
    let longitude, latitude, zoom, favoritesCount: String?
    let nameByLang, descriptionByLang: String?
    let mainMediaURL: String?
    let mediaLinks: [MediaLink]?
    let isFavorited: Bool?
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id
        case enName = "en_name"
        case arName = "ar_name"
        case enDescription = "en_description"
        case arDescription = "ar_description"
        case phone, address
        case viewsCount = "views_count"
        case averageRate = "average_rate"
        case categoryID = "category_id"
        case creatorID = "creator_id"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case facebook, twitter, linkedin, instagram, snapchat, youtube, longitude, latitude, zoom
        case favoritesCount = "favorites_count"
        case nameByLang = "name_by_lang"
        case descriptionByLang = "description_by_lang"
        case mainMediaURL = "main_media_url"
        case mediaLinks = "media_links"
        case isFavorited = "is_favorited"
        case category
    }
}

