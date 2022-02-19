//
//  GeneralModel.swift
//  Dalel
//
//  Created by Shgardi on 19/02/2022.
//

import Foundation

// MARK: - GeneralModel
struct GeneralModel: Codable {
    let payload: GeneralModelPayload?
    let status: Bool?
    let code: Int?
    let messages: JSONNull?
}

// MARK: - Payload
struct GeneralModelPayload: Codable {
    let basic: Basic?
    let about: About?
    let social: Social?
}

// MARK: - About
struct About: Codable {
    let aboutUs, mission, vision, termsAndConditions: String?
    let privacyPolicy: String?

    enum CodingKeys: String, CodingKey {
        case aboutUs = "about_us"
        case mission, vision
        case termsAndConditions = "terms_and_conditions"
        case privacyPolicy = "privacy_policy"
    }
}

// MARK: - Basic
struct Basic: Codable {
    let email, phone, address: String?
    let mapURL: String?

    enum CodingKeys: String, CodingKey {
        case email, phone, address
        case mapURL = "map_url"
    }
}

// MARK: - Social
struct Social: Codable {
    let facebook: String?
    let twitter, linkedin: String?
    let instagram, snapchat: String?
    let youtube: String?
}
