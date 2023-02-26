//
//  ViewController.swift
//  Drinks
//
//  Created by Admin on 22/02/2023.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBox: UITextField!
    var viewModel = DrinkViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 100.0
    }
    @IBAction func onSearchClick(_ sender: Any) {
        viewModel.getDrinksData(ingredient: self.searchBox.text){ [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let drinkCount = self.viewModel.drinks?.count ?? 0
        if drinkCount == 0 {
            tableView.setMessage("No results")
        } else {
            tableView.clearBackground()
        }
        return drinkCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkInfoCell", for: indexPath)
            
            if let cell = cell as? DrinkInfoCell, let drink = self.viewModel.drinks?[indexPath.row], let image = drink.image{
                cell.drinkName?.text = drink.name
                        HttpRequestHelper.shared.downloadImage(from: image){
                            downloadedImage in
                            DispatchQueue.main.async {
                                cell.drinkImage?.image = downloadedImage
                                cell.layoutSubviews()
                            }
                            
                        }
                    }
            return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DrinkDetailView", bundle: nil);
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailView") as? DrinkDetailViewController, let drinkId =  self.viewModel.drinks?[indexPath.row].id{
            vc.id = drinkId
            self.present(vc, animated: true, completion: nil);
        }
        
    }
    
}
extension UITableView {
    
    func setMessage(_ message: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textAlignment = .center
        lblMessage.sizeToFit()
        
        self.backgroundView = lblMessage
        self.separatorStyle = .none
    }
    
    func clearBackground() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
