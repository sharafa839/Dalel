//
//  Logout.swift
//  Dalel
//
//  Created by Shgardi on 05/02/2022.
//

import Foundation
// MARK: - LogoutModel
struct LogoutModel: Codable {
    var payload: [JSONAny]?
    var status: Bool?
    var code: Int?
    var messages: String?
}

