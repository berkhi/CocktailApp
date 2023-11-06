//
//  DrinksDetailViewModel.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

class DrinksDetailViewModel {
    private let drinksDetailServices : APIManagerProtocol
    
    weak var outputDetail: DrinksDetailViewModelOutput?
    
    init(drinksDetailServices: APIManagerProtocol) {
        self.drinksDetailServices = drinksDetailServices
        
    }
    
    func fetchDrinksDetail(for id: String) {
         drinksDetailServices.fetchDrinkDetails(for: id, completion: { result in
             switch result {
             case .success(let drinkDetails):
                 self.outputDetail?.updateView(drinks: drinkDetails)
             case .failure(let error):
                 print("Error fetching drink details: \(error)")
                 self.outputDetail?.updateView(drinks: [])
             }
         })
     }
    
}
