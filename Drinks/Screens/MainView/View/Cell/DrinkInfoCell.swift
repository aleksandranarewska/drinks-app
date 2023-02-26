//
//  DrinkCellInfoController.swift
//  Drinks
//
//  Created by Admin on 26/02/2023.
//

import Foundation
import UIKit
class DrinkInfoCell : UITableViewCell{

    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.drinkName.textColor = .purple
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            drinkName.text = nil
            drinkImage.image = nil
        }
}
