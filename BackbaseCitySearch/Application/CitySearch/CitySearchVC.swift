//
//  CitySearchVC.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import UIKit

class CitySearchVC: UIViewController {
    private let viewModel = CitySearchVM()
    
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

// MARK: - UITableView DataSource
extension CitySearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let city = viewModel.cityList[safe: indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeue(cellClass: CityCell.self, forIndexPath: indexPath)
        cell.configure(titleLabelText: "\(city.name) - \(city.country)",
                       subtitleLabelText: "\(city.coordinate.latitude ?? 0), \(city.coordinate.longitude ?? 0)")
        return cell
    }
}
