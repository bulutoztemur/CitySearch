//
//  FilteringUtil.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 2.02.2022.
//

import Foundation

final class FilteringUtil {
    static func filter(list: [City], prefix: String) -> [City] {
        return binarySearch(list: list, low: 0, high: list.count - 1, prefix: prefix)
    }

    private static func binarySearch(list: [City], low: Int, high: Int, prefix: String) -> [City] {
        if low > high {
            return []
        }
        
        let mid = (high + low) / 2
        if list[mid].name.lowercased().hasPrefix(prefix.lowercased()) {
            return visitAdjacents(list: list, currentPosition: mid, prefix: prefix)
        } else if list[mid].name.lowercased() > prefix.lowercased() {
            return binarySearch(list: list, low: low, high: mid - 1, prefix: prefix)
        } else {
            return binarySearch(list: list, low: mid + 1, high: high, prefix: prefix)
        }
    }

    private static func visitAdjacents(list: [City], currentPosition: Int, prefix: String) -> [City] {
        let leftBoundaryIndex = visitLeftAdjacents(list, currentPosition, prefix)
        let rightBoundaryIndex = visitRightAdjacents(list, currentPosition, prefix)
        return Array(list[leftBoundaryIndex...rightBoundaryIndex])
    }

    private static func visitLeftAdjacents(_ list: [City], _ currentPosition: Int, _ prefix: String) -> Int {
        var leftTraverserIndex = currentPosition
        while leftTraverserIndex > 0 && list[leftTraverserIndex - 1].name.lowercased().hasPrefix(prefix.lowercased()) {
            leftTraverserIndex -= 1
        }
        return leftTraverserIndex
    }

    private static func visitRightAdjacents(_ list: [City], _ currentPosition: Int, _ prefix: String) -> Int {
        var rightTraverserIndex = currentPosition
        while rightTraverserIndex < list.count - 1 && list[rightTraverserIndex + 1].name.lowercased().hasPrefix(prefix.lowercased()) {
            rightTraverserIndex += 1
        }
        return rightTraverserIndex
    }

}
