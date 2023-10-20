//
//  Dish.swift
//  GRDB-tutorial-setup
//
//  Created by Vebjørn Daniloff on 9/7/23.
//

import Foundation
import GRDB


struct Dish: Identifiable, Codable {
    var id: Int64?
    var restaurantId: Int64
    var name: String
}

extension Dish: TableRecord, FetchableRecord, EncodableRecord, PersistableRecord {}
