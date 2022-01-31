//
//  CitySearchVM.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import Foundation

final class CitySearchVM {
    let cityList: [City] = {
        var cities = Bundle.main.decode([City].self, from: "cities.json")
        cities.sort { $0.name < $1.name }
        return cities
    }()
}
