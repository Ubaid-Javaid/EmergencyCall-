//
//  MapViewController.swift
//  emergencycallalipanhwar
//
//  Created by Mohammad ali panhwar on 5/24/18.
//  Copyright © 2018 Mohammad ali panhwar. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON


class MapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate{
    
 
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var map1: GMSMapView!
    
    
    @IBOutlet weak var Designview: DesignView!
    
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    var myLocation:CLLocationCoordinate2D?
    
    var marker2 = GMSMarker()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        self.Designview.isHidden = false
        
        
     

        let camera = GMSCameraPosition.camera(withLatitude: 38.332442, longitude: -123.032234, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.map1.camera = camera
       
        // User Location
        locationManager.delegate = self
        self.map1.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        map1.isMyLocationEnabled = true
        
        marker2.position = CLLocationCoordinate2D(latitude: 24.8705, longitude: 67.0949)
       marker2.icon = imageWithImage(image: #imageLiteral(resourceName: "logo-1"), scaledToSize: CGSize(width: 60.0, height: 60.0))
        marker2.map = map1
        
        
        
        
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation1 = locations.last
        let location1 = CLLocationCoordinate2D(latitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!)
        
        myLocation = location1
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation1?.coordinate.latitude)!,longitude: (userLocation1?.coordinate.longitude)!, zoom: 13.0)
        map1.camera = camera
        self.map1?.animate(to: camera)

     
        locationManager.stopUpdatingLocation()
        
     
  
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
                polyline.map = self.map1
                }
                
            
            
        }
    }

   
   
    @IBAction func CallDriveButton(_ sender: Any) {
 
        drawPath(startLocation: myLocation!, endLocation: marker2.position)
    
        
        
    }


    @IBAction func Navbtn(_ sender: Any) {
        self.performSegue(withIdentifier: "GotoNav1", sender: self)
    }
    
    

    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

   

    
}
