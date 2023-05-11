//
//  MapVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 27/04/23.
//

import UIKit
import MapKit
class MapVC: UIViewController {

    @IBOutlet weak var bottomView: UIView!{
        didSet{
            bottomView.transform = .init(translationX: 0, y: 400)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    var data : LocationDM!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let annotation = MKPointAnnotation()
        if let lat = Double(data.latitude), let lon = Double(data.longitude){
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        
        annotation.title = data.addressName
        annotation.subtitle = MapVC.getDateFromUnixStamp(inputDate: data.date)
        
        // add the annotation to the map view
        mapView.addAnnotation(annotation)
        
        // set the map view's region to center on the annotation
        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}

extension MapVC: MKMapViewDelegate{
    
}









