//
//  Drinks.swift
//  CocktailApp
//
//  Created by BerkH on 26.10.2023.
//

import Foundation

struct DrinksData: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}


