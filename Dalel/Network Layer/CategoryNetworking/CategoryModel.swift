//
//  CategoryModel.swift
//  Dalel
//
//  Created by Shgardi on 11/02/2022.
//

import Foundation
struct CategoriesModel: Codable {
    var payload: [[String: String?]]?
    var status: Bool?
    var code: Int?
    var messages: String?
}
