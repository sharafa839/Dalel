//
//  NotificationModel.swift
//  Dalel
//
//  Created by  on 25/02/2022.
//

import Foundation
struct NotificationModel: Codable {
    let payload: [NotificationModelPayload]?
    let links: Links?
    let meta: Meta?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}


// MARK: - Payload
struct NotificationModelPayload: Codable {
    let id, type, notifiableType, notifiableID: String?
    let data: DataClass?
    let readAt, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case notifiableType = "notifiable_type"
        case notifiableID = "notifiable_id"
        case data
        case readAt = "read_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let subject, message: String?
    let reviewLink: String?
    let color, icon, dataFor, action: String?
    let center: Center?
    let centerService: CenterService?
    let centerID, serviceID, userID, userName: String?
    let userLogo: String?

    enum CodingKeys: String, CodingKey {
        case subject, message
        case reviewLink = "review_link"
        case color, icon
        case dataFor = "for"
        case action, center
        case centerService = "center_service"
        case centerID = "center_id"
        case serviceID = "service_id"
        case userID = "user_id"
        case userName = "user_name"
        case userLogo = "user_logo"
    }
}

// MARK: - Center
struct Center: Codable {
    let id, enName, arName, enDescription: String?
    let arDescription, phone, address: String?
    let viewsCount, averageRate: Int?
    let categoryID, creatorID: String?
    let deletedAt: JSONNull?
    let createdAt, updatedAt: String?
    let facebook, twitter, linkedin, instagram: JSONNull?
    let snapchat, youtube: JSONNull?
    let longitude, latitude, zoom: String?
    let favoritesCount: Int?
    let nameByLang, descriptionByLang, mainMediaURL: String?
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


// MARK: - CenterService
struct CenterService: Codable {
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
