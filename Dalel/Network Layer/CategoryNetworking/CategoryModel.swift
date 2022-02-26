//
//  CategoryModel.swift
//  Dalel
//
//  Created by  on 11/02/2022.
//

import Foundation
struct CategoriesModel: Codable {
        var messages: JSONNull?
        var status: Bool?
        var code: Int?
        var payload: [CategoriesModelPayload]?
    }

    // MARK: - Payload
    struct CategoriesModelPayload: Codable {
        var updatedAt, nameByLang, createdAt: String?
        var enDescription: String?
        var status, creatorID, arName: String?
        var arDescription: String?
        var id: String?
        var descriptionByLang: String?
        var categoryOrder: Int?
        var icon: String?
        var deletedAt: JSONNull?
        var enName: String?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated_at"
            case nameByLang = "name_by_lang"
            case createdAt = "created_at"
            case enDescription = "en_description"
            case status
            case creatorID = "creator_id"
            case arName = "ar_name"
            case arDescription = "ar_description"
            case id
            case descriptionByLang = "description_by_lang"
            case categoryOrder = "category_order"
            case icon
            case deletedAt = "deleted_at"
            case enName = "en_name"
        }
    }

    // MARK: - Encode/decode helpers

    @objcMembers class JSONNull: NSObject, Codable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        override public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
