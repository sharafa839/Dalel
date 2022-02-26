//
//  SubmitReview.swift
//  Dalel
//
//  Created by  on 17/02/2022.
//

import Foundation
struct SubmitReview: Codable {
    let payload: [JSONAny]?
    let status: Bool?
    let code: Int?
    let messages: String?
}
