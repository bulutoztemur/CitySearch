//
//  CitySearchVM.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import Foundation

final class CitySearchVM {
    var cityList: [City]
    var filteredCityList: [City]
    
    init(jsonFileName: String = "cities.json") {
        cityList = Bundle.main.decode([City].self, from: jsonFileName)
        cityList.sort { $0.name.lowercased() < $1.name.lowercased() }
        filteredCityList = cityList
    }
    
    func filterCityList(searchText: String) {
        guard !searchText.isEmpty else {
            filteredCityList = cityList
            return
        }
        filteredCityList = FilteringUtil.filter(list: cityList, prefix: searchText)
    }
}
