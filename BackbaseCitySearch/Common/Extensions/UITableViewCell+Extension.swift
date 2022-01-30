//
//  UITableViewCell+Extension.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import UIKit

public extension UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
