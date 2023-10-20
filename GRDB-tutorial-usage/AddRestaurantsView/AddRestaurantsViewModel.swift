//
//  RestaurantsViewModel.swift
//  GRDB-tutorial-setup
//
//  Created by Vebjørn Daniloff on 9/7/23.
//

import Foundation
import Combine
final class AddRestaurantsViewModel: ObservableObject {
    @Published var restaurantName = ""
    @Published var dish_1 = ""
    @Published var dish_2 = ""

    private let db = LocalDatabase.shared

    func createRestaurant() async {
        guard !(restaurantName.isEmpty && dish_1.isEmpty && dish_2.isEmpty) else {
            return
        }

        do {
            let restaurant = Restaurant(name: restaurantName)

            try await db.insertRestaurantAndDishes(restaurant: restaurant, dish_1: dish_1, dish_2: dish_2)
        } catch {
            print(error)
        }
    }
}
