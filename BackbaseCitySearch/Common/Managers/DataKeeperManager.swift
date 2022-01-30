//
//  DataKeeperManager.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import Foundation

final class DataKeeperManager {
    static let cityInfo = Bundle.main.decode([City].self, from: "cities.json")
}
