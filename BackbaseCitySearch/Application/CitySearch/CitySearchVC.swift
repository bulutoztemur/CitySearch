//
//  CitySearchVC.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import UIKit

class CitySearchVC: UIViewController {
    @IBOutlet weak private var citySearchBar: UISearchBar!
    @IBOutlet weak private var cityTableView: UITableView! {
        didSet {
            cityTableView.register(cellClass: CityCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CitySearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataKeeperManager.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: CityCell.self, forIndexPath: indexPath)
        guard let city = DataKeeperManager.cityList[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(titleLabelText: "\(city.name) - \(city.country)",
                       subtitleLabelText: "(\(city.coordinate.latitude ?? 0), \(city.coordinate.longitude ?? 0))")
        return cell
    }
    
    
}
