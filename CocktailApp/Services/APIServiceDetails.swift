//
//  APIService.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

protocol DrinksDetailService {
    func fetchDrinkDetails(for id: String, completion: @escaping (Result<[DrinkDetail], Error>) -> ())
}

class APIServiceDetails: DrinksDetailService {

    func fetchDrinkDetails(for id: String, completion: @escaping (Result<[DrinkDetail], Error>) -> ()){
        let cocktailExtension = Constants.Urls.cocktailDetailsExtension + id
        if let url = URL(string: cocktailExtension) {
            URLSession.shared.dataTask(with: url) {data, response, error in
                guard let data = data else {
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(DrinkDetails.self, from: data)
                    let drinks = decodedData.drinks
                    completion(.success(drinks))
                } catch let error {
                    completion(.failure(error))
                }
                
            }.resume()
        }
        
    }
}
