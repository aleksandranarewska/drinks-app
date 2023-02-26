//
//  DrinkViewModel.swift
//  Drinks
//
//  Created by Admin on 22/02/2023.
//

import Foundation
import UIKit
class DrinkViewModel {
    
    var drinks : [Drink]?
    
    func getDrinksData(ingredient : String?, complete : @escaping () -> ())  {
        if let url = ingredientToUrl(ingredient){
            HttpRequestHelper.shared.getData(type: DrinkDataModel(), url: url){ value in
                self.drinks = value?.drinks
                complete()
            }
        }else{
            self.drinks = nil
            complete()
        }
    }
    func ingredientToUrl(_ ingredient: String?) -> URL?{
        if let searchableIngredient = ingredient?.replacingOccurrences(of: " ", with: "_"), let url = URL(string: Constants.UrlConstants.searchByIngredientUrl + searchableIngredient) {
            return url
        }
        return nil

    }
}
