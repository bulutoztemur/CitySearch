//
//  Array+Extension.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 31.01.2022.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
