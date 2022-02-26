//
//  singleCenterModel.swift
//  Dalel
//
//  Created by  on 15/02/2022.
//

import Foundation

// MARK: - SingleCenterModel
struct SingleCenterModel: Codable {
    let payload: SingleCenterPayload?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}

// MARK: - Payload
struct SingleCenterPayload: Codable {
    let id, enName, arName, enDescription: String?
    let arDescription, phone: String?
    let address: String?
    let viewsCount: String?
    let averageRate, categoryID, creatorID: String?
    let deletedAt: JSONNull?
    let createdAt, updatedAt: String?
    let facebook, twitter, linkedin, instagram: String?
    let snapchat, youtube, longitude, latitude: String?
    let zoom: String?
    let favoritesCount, nameByLang, descriptionByLang: String?
    let mainMediaURL: String?
    let mediaLinks: [MediaLink]?
    let isFavorited: Bool?
    let category: Category?
    let workTimes: [WorkTime]?
    let services: [Service]?

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
        case workTimes = "work_times"
        case services
    }
}
// MARK: - Service
struct Service: Codable {
    let id, title: String?
    let serviceDescription: JSONNull?
    let centerID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case serviceDescription = "description"
        case centerID = "center_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
// MARK: - Category


// MARK: - MediaLink

// MARK: - WorkTime
struct WorkTime: Codable {
    let id, enDayName, arDayName, dayOrder: String?
    let dayIsVacation: Bool?
    let openTime, closeTime, centerID, createdAt: String?
    let updatedAt, dayNameByLang: String?

    enum CodingKeys: String, CodingKey {
        case id
        case enDayName = "en_day_name"
        case arDayName = "ar_day_name"
        case dayOrder = "day_order"
        case dayIsVacation = "day_is_vacation"
        case openTime = "open_time"
        case closeTime = "close_time"
        case centerID = "center_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dayNameByLang = "day_name_by_lang"
    }
}
