//
//  DrinksViewModelOutput.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

protocol DrinksViewModelOutput: AnyObject {
    func updateView(drinks: [Drink])
}
