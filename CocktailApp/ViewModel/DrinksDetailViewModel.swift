//
//  DrinksDetailViewModel.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation

class DrinksDetailViewModel {
    private let drinksDetailServices : DrinksDetailService
    
    weak var outputDetail: DrinksDetailViewModelOutput?
    
    init(drinksDetailServices: DrinksDetailService) {
        self.drinksDetailServices = drinksDetailServices
        
    }
    
    func fetchDrinksDetail(for id: String) {
         drinksDetailServices.fetchDrinkDetails(for: id, completion: { result in
             switch result {
             case .success(let drinkDetails):
                 let drinks: [DrinkDetail] = drinkDetails.map {
                     DrinkDetail(idDrink: $0.idDrink, strDrink: $0.strDrink, strCategory: $0.strCategory, strGlass: $0.strGlass, strInstructions: $0.strInstructions, strDrinkThumb: $0.strDrinkThumb)
                 }
                 self.outputDetail?.updateView(drinks: drinks)
             case .failure(let error):
                 print("Error fetching drink details: \(error)")
                 self.outputDetail?.updateView(drinks: [])
             }
         })
     }
    
}
