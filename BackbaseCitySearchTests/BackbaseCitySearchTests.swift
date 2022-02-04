//
//  BackbaseCitySearchTests.swift
//  BackbaseCitySearchTests
//
//  Created by alaattinbulut on 30.01.2022.
//

import XCTest
@testable import BackbaseCitySearch

class BackbaseCitySearchTests: XCTestCase {

    private var viewModel: CitySearchVM!
    
    override func setUpWithError() throws {
        viewModel = CitySearchVM()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func improvedLinearSearch(list: [City], prefix: String) -> [City] {
        var firstIndex = -1
        var lastIndex = -1
        for (index, city) in list.enumerated() {
            if firstIndex == -1 && city.name.lowercased().hasPrefix(prefix.lowercased()) {
                firstIndex = index
            }
            
            if lastIndex == -1 && firstIndex != -1 && !city.name.lowercased().hasPrefix(prefix.lowercased()) {
                lastIndex = index - 1
            }
            
            if firstIndex != -1 && lastIndex != -1 {
                return Array(list[firstIndex...lastIndex])
            }
        }
        
        if firstIndex != -1 && lastIndex == -1 {
            return Array(list[firstIndex...list.count - 1])
        }
        
        return []
    }

    func test_decode_and_sort_operations() throws {
        // Given
        XCTAssertEqual(viewModel.filteredCityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        // Then
        XCTAssertNotEqual(viewModel.cityList, [])
        XCTAssertEqual(viewModel.cityList.count, 209557)
        XCTAssertEqual(viewModel.cityList, viewModel.filteredCityList)
        XCTAssertTrue(viewModel.cityList.map { $0.name.lowercased() }.isSorted(isOrderedBefore: <=))
    }
    
    func test_empty_json_data() {
        // Given
        XCTAssertEqual(viewModel.cityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "empty.json")
        
        // Then
        XCTAssertEqual(viewModel.cityList, [])
    }
    
    func test_validate_filter_operation_for_input_aa() {
        // Given
        XCTAssertEqual(viewModel.filteredCityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        viewModel.filterCityList(searchText: "aa")
        
        // Then
        XCTAssertNotEqual(viewModel.filteredCityList, viewModel.cityList)
        XCTAssertEqual(viewModel.filteredCityList, viewModel.cityList.filter { $0.name.lowercased().hasPrefix("aa") })
        XCTAssertTrue(viewModel.filteredCityList.map { $0.name.lowercased() }.isSorted(isOrderedBefore: <=))
    }
    
    func test_validate_filter_operation_for_input_tata() {
        // Given
        XCTAssertEqual(viewModel.filteredCityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        viewModel.filterCityList(searchText: "tata")
        
        // Then
        XCTAssertNotEqual(viewModel.filteredCityList, viewModel.cityList)
        XCTAssertEqual(viewModel.filteredCityList, viewModel.cityList.filter { $0.name.lowercased().hasPrefix("tata") })
        XCTAssertTrue(viewModel.filteredCityList.map { $0.name.lowercased() }.isSorted(isOrderedBefore: <=))
    }
    
    func test_empty_input() {
        // Given
        XCTAssertEqual(viewModel.cityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        viewModel.filterCityList(searchText: "")
        
        // Then
        XCTAssertNotEqual(viewModel.filteredCityList, [])
        XCTAssertEqual(viewModel.filteredCityList, viewModel.cityList)
    }
    
    func test_trimming_input() {
        // Given
        XCTAssertEqual(viewModel.cityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        viewModel.filterCityList(searchText: "\n Amsterdam \n \n  ")
        
        // Then
        XCTAssertNotEqual(viewModel.filteredCityList, [])
    }
    
    func test_only_whitespace_and_newlines_input() {
        // Given
        XCTAssertEqual(viewModel.cityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        viewModel.filterCityList(searchText: "\n \n \n  ")
        
        // Then
        XCTAssertNotEqual(viewModel.filteredCityList, [])
        XCTAssertEqual(viewModel.filteredCityList, viewModel.cityList)
    }
    
    func test_improved_linear_search_algorithm() {
        // Given
        XCTAssertEqual(viewModel.cityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        
        // Then
        XCTAssertEqual(improvedLinearSearch(list: viewModel.cityList, prefix: "Ams"), viewModel.cityList.filter { $0.name.lowercased().hasPrefix("Ams".lowercased()) })
    }
    
    func test_invalid_input() {
        // Given
        XCTAssertEqual(viewModel.filteredCityList, [])

        // When
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        viewModel.filterCityList(searchText: "Axawqy")
        
        // Then
        XCTAssertNotEqual(viewModel.filteredCityList, viewModel.cityList)
        XCTAssertEqual(viewModel.filteredCityList, [])
    }
    
    func test_validate_performance_test_cases_in_both_algorithms() {
        viewModel.decodeJsonData(jsonFileName: "cities.json")
        
        viewModel.filterCityList(searchText: "Ams")
        XCTAssertEqual(viewModel.filteredCityList, improvedLinearSearch(list: viewModel.cityList, prefix: "Ams"))
        
        viewModel.filterCityList(searchText: "Kala")
        XCTAssertEqual(viewModel.filteredCityList, improvedLinearSearch(list: viewModel.cityList, prefix: "Kala"))
        
        viewModel.filterCityList(searchText: "Zaba")
        XCTAssertEqual(viewModel.filteredCityList, improvedLinearSearch(list: viewModel.cityList, prefix: "Zaba"))
    }

    func test_filter_algorithm_performans_input_ams() throws {
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        self.measure {
            viewModel.filterCityList(searchText: "Ams")
        }
    }
    
    func test_linear_algorithm_performans_input_ams() throws {
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        self.measure {
            let _ = improvedLinearSearch(list: viewModel.cityList, prefix: "Ams")
        }
    }
    
    func test_filter_algorithm_performans_input_kala() throws {
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        self.measure {
            viewModel.filterCityList(searchText: "Kala")
        }
    }
    
    func test_linear_algorithm_performans_input_kala() throws {
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        self.measure {
            let _ = improvedLinearSearch(list: viewModel.cityList, prefix: "Kala")
        }
    }

    func test_filter_algorithm_performans_input_zaba() throws {
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        self.measure {
            viewModel.filterCityList(searchText: "Zaba")
        }
    }
    
    func test_linear_algorithm_performans_input_zaba() throws {
        viewModel.decodeJsonData(jsonFileName: "cities.json")

        self.measure {
            let _ = improvedLinearSearch(list: viewModel.cityList, prefix: "Zaba")
        }
    }
}
