//
//  DetailedDrink.swift
//  Drinks
//
//  Created by Admin on 25/02/2023.
//

import Foundation
class DetailedDrink : Drink{
    var instructions : String?
    required init(from decoder: Decoder) {
        super.init(from: decoder)
        do {
            let container = try decoder.container(keyedBy: DetailedDrinkCodingKeys.self)
            instructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        } catch let error {
            print("Error decoding drink data: \(error.localizedDescription)")
            instructions = ""
        }
    }
}
