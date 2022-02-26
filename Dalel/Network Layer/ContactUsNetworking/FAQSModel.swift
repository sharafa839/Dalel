//
//  FAQSModel.swift
//  Dalel
//
//  Created by  on 20/02/2022.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//


// MARK: - FaqsModel
struct FaqsModel: Codable {
    let payload: [FAQSPayload]?
    let links: Links?
    let meta: Meta?
    let status: Bool?
    let code: Int?
    let messages: String?
}

// MARK: - Links

// MARK: - Payload
struct FAQSPayload: Codable {
    let id, enQuestion, arQuestion, enAnswer: String?
    let arAnswer, status, creatorID: String?
    let deletedAt: String?
    let createdAt, updatedAt, questionByLang, answerByLang: String?

    enum CodingKeys: String, CodingKey {
        case id
        case enQuestion = "en_question"
        case arQuestion = "ar_question"
        case enAnswer = "en_answer"
        case arAnswer = "ar_answer"
        case status
        case creatorID = "creator_id"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case questionByLang = "question_by_lang"
        case answerByLang = "answer_by_lang"
    }
}

// MARK: - Encode/decode helpers
