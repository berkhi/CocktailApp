//
//  Constants.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import Foundation


struct Constants {
    
    struct Urls {
        static let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
        static let cocktailExtension  = "\(baseUrl)filter.php?c=Cocktail"
        static let cocktailDetailsExtension  = "\(baseUrl)lookup.php?i="
    }
    
}
