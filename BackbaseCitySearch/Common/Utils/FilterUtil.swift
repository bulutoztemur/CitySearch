//
//  FilterUtil.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 2.02.2022.
//

import Foundation

final class FilterUtil {
    static func filter<T:Filterable>(list: [T], prefix: String) -> [T] {
        return binarySearch(list: list, low: 0, high: list.count - 1, prefix: prefix)
    }

    private static func binarySearch<T:Filterable>(list: [T], low: Int, high: Int, prefix: String) -> [T] {
        if low > high {
            return []
        }
        
        let mid = (high + low) / 2
        if list[mid].filterString.lowercased().hasPrefix(prefix.lowercased()) {
            return visitAdjacents(list: list, currentPosition: mid, prefix: prefix)
        } else if list[mid].filterString.lowercased() > prefix.lowercased() {
            return binarySearch(list: list, low: low, high: mid - 1, prefix: prefix)
        } else {
            return binarySearch(list: list, low: mid + 1, high: high, prefix: prefix)
        }
    }

    private static func visitAdjacents<T:Filterable>(list: [T], currentPosition: Int, prefix: String) -> [T] {
        let leftBoundaryIndex = visitLeftAdjacents(list, currentPosition, prefix)
        let rightBoundaryIndex = visitRightAdjacents(list, currentPosition, prefix)
        return Array(list[leftBoundaryIndex...rightBoundaryIndex])
    }

    private static func visitLeftAdjacents<T:Filterable>(_ list: [T], _ currentPosition: Int, _ prefix: String) -> Int {
        var leftTraverserIndex = currentPosition
        while leftTraverserIndex > 0 && list[leftTraverserIndex - 1].filterString.lowercased().hasPrefix(prefix.lowercased()) {
            leftTraverserIndex -= 1
        }
        return leftTraverserIndex
    }

    private static func visitRightAdjacents<T:Filterable>(_ list: [T], _ currentPosition: Int, _ prefix: String) -> Int {
        var rightTraverserIndex = currentPosition
        while rightTraverserIndex < list.count - 1 && list[rightTraverserIndex + 1].filterString.lowercased().hasPrefix(prefix.lowercased()) {
            rightTraverserIndex += 1
        }
        return rightTraverserIndex
    }
}
