//
//  BannerModel.swift
//  Dalel
//
//  Created by Shgardi on 12/02/2022.
//

import Foundation

// MARK: - CenterModel
struct BannerModel: Codable {
    var payload: [[String: String?]]?
    var status: Bool?
    var code: Int?
    var messages: JSONNull?
}
