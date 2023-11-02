//
//  DrinkDetails.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

struct DrinkDetails: Decodable {
    let drinks: [DrinkDetail]
}

struct DrinkDetail: Decodable {
    let idDrink: String
    let strDrink: String
    let strCategory: String
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: String
}
