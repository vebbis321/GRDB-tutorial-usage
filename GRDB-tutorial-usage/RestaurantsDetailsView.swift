//
//  RestaurantsDetailsView.swift
//  GRDB-Draft
//
//  Created by Vebjørn Daniloff on 9/7/23.
//

import SwiftUI

struct RestaurantDetailsView: View {

    @State var dishes = [Dish]()
    var restaurant: Restaurant
    var body: some View {
        List(dishes) { dish in
            Text(dish.name)
        }.task {
            dishes = try! await LocalDatabase.shared.getDishesForRestaurant(restaurant)
        }
        .navigationTitle(restaurant.name)
    }
}
