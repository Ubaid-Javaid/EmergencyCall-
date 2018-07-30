//
//  MapViewDemo.swift
//  EmergencyCall
//
//  Created by Ubaid on 6/5/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class MapViewDemo: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var MapView1: GMSMapView!
    
    var locationManager
        = CLLocationManager()
    var latitude = 24.86136
    var longitude = 67.07357
    var prevlong = 67.07357
    var prelat = 24.86136
    var zoom:Float = 10.00

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()

    }

    func determineMyCurrentLocation() {
        //locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            self.locationManager.stopUpdatingLocation()
            
           
           MapView1.isMyLocationEnabled = true
            
        }
    }
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])   {
    let userLocation:CLLocation = locations[0] as CLLocation
    
    self.latitude = userLocation.coordinate.latitude
    self.longitude = userLocation.coordinate.longitude
    if(!(self.prelat==latitude) || !(prevlong == longitude)){
    let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: zoom)
        var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    
 MapView1.camera = camera
        MapView1.animate(to: camera)
    
    
    
    
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
                marker.title = "Karachi"
                marker.snippet = "Pakistan"
                marker.map = mapView
  
    
    
        
    
    
    print("user latitude = \(userLocation.coordinate.latitude)")
    print("user longitude = \(userLocation.coordinate.longitude)")
    prelat = latitude
    prevlong = longitude
    
    
    
    
    
    
    }
    
    }
    
    func  locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

 

}
