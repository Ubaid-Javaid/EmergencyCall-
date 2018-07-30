//
//  mapView2.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/26/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import Alamofire
import SwiftyJSON


class mapView2: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate
{
    
    
    
    @IBOutlet weak var MapView: GMSMapView!
    
    
   lazy var mapView1 = GMSMapView()
    
   
    
    
    
    
  // @IBOutlet weak var subview1: UIView!
    var locationManager
        = CLLocationManager()
//    var latitude = 24.86136
//    var longitude = 67.07357
//    var prevlong = 67.07357
//    var prelat = 24.86136
//    var zoom:Float = 13.5
    
     let marker1 = GMSMarker()
    var mylocation:CLLocationCoordinate2D?
  
    
    
    
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 38.332442, longitude: -123.032234, zoom: 13.0)
        mapView1 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.MapView.camera = camera
        // User Location
        
        locationManager.delegate = self
        self.MapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        MapView.isMyLocationEnabled = true
        
//           determineMyCurrentLocation()
//
//                self.MapView.delegate = self
        

        
        
        
    }
    
//    func determineMyCurrentLocation() {
//        //locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.stopMonitoringSignificantLocationChanges()
//
//        locationManager.startUpdatingLocation()
//        if CLLocationManager.locationServicesEnabled() {
//            //locationManager.startUpdatingLocation()
//            self.locationManager.stopUpdatingLocation()
//            self.MapView.isMyLocationEnabled = true
//        }
//    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//        let location2 = locations.last
//        let aLocation = CLLocationCoordinate2D(latitude: (location2?.coordinate.latitude)!, longitude: (location2?.coordinate.longitude)!)
//
//        location1 = aLocation
//
//        self.latitude = userLocation.coordinate.latitude
//        self.longitude = userLocation.coordinate.longitude
//
//
//        if(!(self.prelat==latitude) || !(prevlong == longitude)){
//            let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: zoom)
//             mapView1 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//            MapView.camera = camera
//            MapView.animate(to: camera)
        let userLocation1 = locations.last
        let location1 = CLLocationCoordinate2D(latitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!)
        mylocation = location1
        
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!, zoom: 13.0)
        MapView.camera = camera
        self.MapView?.animate(to: camera)
        
        locationManager.stopUpdatingLocation()
        

            
            
      
            
           
            marker1.position = CLLocationCoordinate2D(latitude: 24.8705,longitude: 67.0949)
            marker1.icon = imageWithImage(image: #imageLiteral(resourceName: "logo-1"), scaledToSize: CGSize(width: 60.0, height: 60.0))
            marker1.title = "Karachi"
            marker1.snippet = "Pakistan"
            marker1.map = MapView
            
            
//        print("user latitude = \(userLocation1?.coordinate.latitude)")
//        print("user longitude = \(userLocation1userLocation1.coordinate.longitude)")
//            prelat = latitude
//            prevlong = longitude
        
        }
        
  
    func  locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func CallDriver(_ sender: Any) {
        
               drawPath(startLocation: mylocation!, endLocation: marker1.position)
       
        
    }
    
    @IBAction func NavBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "GotoNav1", sender: self)
    }
    
   
    
    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            
            let json = try! JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.MapView
            }
            
            
            
        }
    }
    

   
}






























