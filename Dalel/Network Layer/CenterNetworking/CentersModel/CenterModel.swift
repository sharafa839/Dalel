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
        let payload: [CenterModelPayload]?
        let links: Links?
        let meta: Meta?
        let status: Bool?
        let code: Int?
        let messages: JSONNull?
    }

    // MARK: - Links
    struct Links: Codable {
        let first, last: String?
        let prev, next: JSONNull?
    }

    // MARK: - Meta
    struct Meta: Codable {
        let currentPage, from, lastPage: Int?
        let path: String?
        let perPage, to, total: Int?

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
        let id, enName, arName, enDescription: String?
        let arDescription, phone, address, viewsCount: String?
        let averageRate, categoryID, creatorID: String?
        let deletedAt: JSONNull?
        let createdAt, updatedAt: String?
        let facebook, twitter, linkedin, instagram: JSONNull?
        let snapchat, youtube: JSONNull?
        let longitude, latitude, zoom, distance: String?
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
            case facebook, twitter, linkedin, instagram, snapchat, youtube, longitude, latitude, zoom, distance
            case nameByLang = "name_by_lang"
            case descriptionByLang = "description_by_lang"
            case mainMediaURL = "main_media_url"
            case mediaLinks = "media_links"
            case isFavorited = "is_favorited"
            case category
        }
    }

    // MARK: - Category
    struct Category: Codable {
        let id, enName, arName, status: String?
        let creatorID: String?
        let deletedAt: JSONNull?
        let createdAt, updatedAt: String?
        let categoryOrder: Int?
        let enDescription, arDescription: String?
        let nameByLang: String?
        let descriptionByLang: String?
        let icon: String?

        enum CodingKeys: String, CodingKey {
            case id
            case enName = "en_name"
            case arName = "ar_name"
            case status
            case creatorID = "creator_id"
            case deletedAt = "deleted_at"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case categoryOrder = "category_order"
            case enDescription = "en_description"
            case arDescription = "ar_description"
            case nameByLang = "name_by_lang"
            case descriptionByLang = "description_by_lang"
            case icon
        }
    }

    // MARK: - MediaLink
    struct MediaLink: Codable {
        let id: Int?
        let link: String?
        let mimeType: MIMEType?

        enum CodingKeys: String, CodingKey {
            case id, link
            case mimeType = "mime_type"
        }
    }

    enum MIMEType: String, Codable {
        case imageJPEG = "image/jpeg"
        case imagePNG = "image/png"
    }

    // MARK: - Encode/decode helpers

    
