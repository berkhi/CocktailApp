//
//  DrinksViewModel.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

class DrinksViewModel {
    private let drinksService: APIManagerProtocol
    weak var output: DrinksViewModelOutput?
    
    init(drinksService: APIManagerProtocol) {
        self.drinksService = drinksService
    }
    
    func fetchDrinks() {
//        print("Fetching drinks...")
        drinksService.fetchDrinks { result in
            switch result {
            case .success(let drink):
//                print("Data received:", drink)
                self.output?.updateView(drinks: drink)
            case .failure(let error):
                print("Error fetching data:", error)
                self.output?.updateView(drinks: [])
            }
        }
    }

    
}
