//
//  CityCell.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    func configure(titleLabelText: String, subtitleLabelText: String) {
        titleLabel.text = titleLabelText
        subtitleLabel.text = subtitleLabelText
    }
}
