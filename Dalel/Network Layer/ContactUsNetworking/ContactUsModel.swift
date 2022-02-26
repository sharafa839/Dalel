//
//  ContactUsModel.swift
//  Dalel
//
//  Created by  on 19/02/2022.
//

import Foundation
struct ContactModel: Codable {
    let payload: [JSONAny]?
    let status: Bool?
    let code: Int?
    let messages: String?
}
