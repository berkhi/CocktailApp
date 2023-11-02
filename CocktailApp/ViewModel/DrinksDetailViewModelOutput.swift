//
//  DrinksDetailViewModelOutput.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

protocol DrinksDetailViewModelOutput: AnyObject {
    func updateView(drinks: [DrinkDetail])
}
