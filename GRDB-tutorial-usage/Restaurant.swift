//
//  Team.swift
//  GRDB-Draft
//
//  Created by Vebjørn Daniloff on 9/7/23.
//

import Foundation
import GRDB

struct Restaurant: Identifiable, Codable {
    var id: Int64?
    var name: String
}

extension Restaurant: EncodableRecord, FetchableRecord {}

extension Restaurant: TableRecord {
    static let dishes = hasMany(Dish.self)

    var dishes: QueryInterfaceRequest<Dish> {
        request(for: Restaurant.dishes)
    }
}

extension Restaurant: MutablePersistableRecord {
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}
