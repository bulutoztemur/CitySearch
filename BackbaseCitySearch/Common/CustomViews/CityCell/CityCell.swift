//
//  CityCell.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import UIKit
import MapKit

final class CityCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    @IBOutlet weak private var cityInfoView: UIView!
    @IBOutlet weak private var stackView: UIStackView!
    private var mapView: MKMapView?
    private var mapViewHeight: CGFloat = 0
    private var coordinate: Coordinate?
    
    func configure(titleLabelText: String, subtitleLabelText: String, mapHeight: CGFloat, cityCoordinate: Coordinate) {
        titleLabel.text = titleLabelText
        subtitleLabel.text = subtitleLabelText
        mapViewHeight = mapHeight
        coordinate = cityCoordinate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected, mapView == nil {
            createMap()
        } else if mapView != nil {
            removeMap()
        }
    }
}

//MARK:- Map Expand Collapse Operations
private extension CityCell {
    func createMap() {
        mapView = MKMapView(frame: .zero)
        guard let mapView = mapView else { return }
        initMapViewCenterLocation(mapView)
        setupMapViewConstraints(mapView)
    }
    
    func initMapViewCenterLocation(_ mapView: MKMapView) {
        let center = CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: false)
    }
    
    func setupMapViewConstraints(_ mapView: MKMapView) {
        stackView.addArrangedSubview(mapView)
        mapView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        let constraint = mapView.heightAnchor.constraint(equalToConstant: mapViewHeight)
        constraint.priority = UILayoutPriority(750)
        constraint.isActive = true
    }
    
    func removeMap() {
        mapView?.removeFromSuperview()
        mapView = nil
    }
}
