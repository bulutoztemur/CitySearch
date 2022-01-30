//
//  UITableView+Extension.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(UINib(nibName: cellClass.nibName, bundle: nil), forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
    }

    func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}
