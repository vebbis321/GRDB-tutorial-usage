//
//  LocalDatabase.swift
//  GRDB-tutorial-setup
//
//  Created by Vebjørn Daniloff on 9/8/23.
//

import Foundation
import GRDB
import Combine

struct LocalDatabase {

    private let writer: DatabaseWriter

    init(_ writer: DatabaseWriter) throws {
        self.writer = writer
        try migrator.migrate(writer)
    }

    var reader: DatabaseReader {
        writer
    }
}

// MARK: - Writes
extension LocalDatabase {
    func insertRestaurantAndDishes(
        restaurant: Restaurant,
        dish_1: String,
        dish_2: String
    ) async throws {
        try await writer.write({ db in
            let restaurant = try restaurant.inserted(db)

            let dish_1 = Dish(restaurantId: restaurant.id!, name: dish_1)
            let dish_2 = Dish(restaurantId: restaurant.id!, name: dish_2)

            try dish_1.insert(db)
            try dish_2.insert(db)
        })
    }
}

// MARK: - Observe
extension LocalDatabase {
    func observeRestaurants() -> AnyPublisher<[Restaurant], Error> {

        let observation = ValueObservation.tracking { db in
            return try Restaurant.fetchAll(db)
        }

        let publisher = observation.publisher(in: reader)
        return publisher.eraseToAnyPublisher()
    }
}

// MARK: - Reads
extension LocalDatabase {
    func getDishesForRestaurant(_ restaurant: Restaurant) async throws -> [Dish] {

        try await reader.read({ db in
            let dishes = try restaurant.dishes.fetchAll(db)
            return dishes
        })
    }
}
