//
//  Drink.swift
//  Drinks
//
//  Created by Admin on 22/02/2023.
//

import Foundation

class Drink : Codable {
    var id : String?
    var name : String?
    var image : String?
    
    required init(from decoder: Decoder) {
        
        do {
            let container = try decoder.container(keyedBy: DrinkCodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .idDrink)
            name = try container.decodeIfPresent(String.self, forKey: .strDrink)
            image = try container.decodeIfPresent(String.self, forKey: .strDrinkThumb)
   
        } catch let error {
            print("Error decoding drink data: \(error.localizedDescription)")
            id = ""
            name = ""
            image = nil
            
        }
        
    }
}

