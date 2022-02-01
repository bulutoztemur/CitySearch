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
            cityTableView.registerWithNib(cellClass: CityCell.self)
            cityTableView.rowHeight = UITableView.automaticDimension
            cityTableView.estimatedRowHeight = 600
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
                       subtitleLabelText: "\(city.coordinate.latitude ?? 0), \(city.coordinate.longitude ?? 0)",
                       tableViewHeight: cityTableView.frame.size.height,
                       cityCoordinate: city.coordinate)
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityTableView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.cityTableView.performBatchUpdates(nil)
            self.scrollToTop(rowNumber: indexPath.row)
            self.cityTableView.isUserInteractionEnabled = true
        }
    }
    
    private func scrollToTop(rowNumber: Int) {
        let topRow = IndexPath(row: rowNumber, section: 0)
        self.cityTableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}
