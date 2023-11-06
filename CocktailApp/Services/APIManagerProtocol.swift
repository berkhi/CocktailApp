//
//  APIManagerProtocol.swift
//  CocktailApp
//
//  Created by BerkH on 7.11.2023.
//

import Foundation

protocol APIManagerProtocol {
    func fetchDrinks(completion: @escaping (Result<[Drink], Error>) -> ())
    func fetchDrinkDetails(for id: String, completion: @escaping (Result<[DrinkDetail], Error>) -> ())
}
