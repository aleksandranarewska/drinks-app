//
//  DrinkDetailViewController.swift
//  Drinks
//
//  Created by Admin on 25/02/2023.
//

import Foundation
import UIKit
class DrinkDetailViewController : UIViewController, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var instructionsField: UITextView!
    
    var viewModel = DrinkDetailViewModel()
    public var id :String!
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getDrinkData(id: self.id){ [weak self] in
            if let drink = self?.viewModel.drink, let image = drink.image{
                HttpRequestHelper.shared.downloadImage(from: image){
                    [weak self] downloadedImage in
                    DispatchQueue.main.async{
                        self?.nameLabel.text = drink.name
                        self?.imageView.image = downloadedImage
                        self?.instructionsField.text = drink.instructions
                    }
                }
            }
            
        }
        
        
    }
}
