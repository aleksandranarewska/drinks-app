//
//  DrinkDetailViewModel.swift
//  Drinks
//
//  Created by Admin on 25/02/2023.
//

import Foundation
class DrinkDetailViewModel {
    
    var drink:DetailedDrink?
    
    func getDrinkData(id : String, complete : @escaping () -> ()) {
        if let url = URL(string: Constants.UrlConstants.searchByIdUrl + id){
            HttpRequestHelper.shared.getData(type: DetailedDrinkDataModel(), url: url){ value in
                self.drink = value?.drinks?.first
                complete()
            }
        }else{
            self.drink = nil
            complete()
        }
    }
}
