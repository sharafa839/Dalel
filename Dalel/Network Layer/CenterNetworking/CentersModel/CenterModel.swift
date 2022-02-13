//
//  CenterModel.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let centerModel = try? newJSONDecoder().decode(CenterModel.self, from: jsonData)

import Foundation

// MARK: - CenterModel
struct CenterModel: Codable {
    var payload: [CenterModelPayload]?
    var links: Links?
    var meta: Meta?
    var status: Bool?
    var code: Int?
    var messages: String?
}

// MARK: - Links
struct Links: Codable {
    var first, last: String?
    var prev, next: String?
}

// MARK: - Meta
struct Meta: Codable {
    var currentPage, from, lastPage: Int?
    var path: String?
    var perPage, to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}

// MARK: - Payload
struct CenterModelPayload: Codable {
    var id, enName, arName, enDescription: String?
    var arDescription, phone, address, viewsCount: String?
    var averageRate, categoryID, creatorID: String?
    var deletedAt: String?
    var createdAt, updatedAt: String?
    var facebook, twitter, linkedin, instagram: String?
    var snapchat, youtube: String?
    var longitude, latitude, zoom, distance: String?
    var nameByLang, descriptionByLang: String?
    var mainMediaURL: String?
    var mediaLinks: [MediaLink]?
    var isFavorited: Bool?
    var category: [String: String?]?

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
        case facebook, twitter, linkedin, instagram, snapchat, youtube, longitude, latitude, zoom, distance
        case nameByLang = "name_by_lang"
        case descriptionByLang = "description_by_lang"
        case mainMediaURL = "main_media_url"
        case mediaLinks = "media_links"
        case isFavorited = "is_favorited"
        case category
    }
}

// MARK: - MediaLink
struct MediaLink: Codable {
    var id: Int?
    var link: String?
    var mimeType: MIMEType?

    enum CodingKeys: String, CodingKey {
        case id, link
        case mimeType = "mime_type"
    }
}

enum MIMEType: String, Codable {
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
}

