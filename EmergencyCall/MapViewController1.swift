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
import GeoFire
import Firebase


class MapViewController1: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate{
    
  
    var timer = Timer()
   
    @IBOutlet weak var menu: UIButton!
    
    @IBOutlet weak var map1: GMSMapView!
    
    @IBOutlet weak var DesignView: UIButton!
    
    @IBOutlet weak var cancel: UIButton!

    @IBOutlet weak var emergency:UIButton!
    
    
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    var myLocation:CLLocationCoordinate2D?
    
   
    var geofire:GeoFire?
    var georeference:DatabaseReference?
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    georeference = Database.database().reference().child("Users")
geofire = GeoFire(firebaseRef: georeference!)
        self.DesignView.isHidden = true
        self.cancel.isHidden = true
        


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
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation1 = locations.last
        let location1 = CLLocationCoordinate2D(latitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!)
        let location2 = CLLocation(latitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!)

        print(userLocation1?.coordinate.latitude)
        print(userLocation1?.coordinate.longitude)
        myLocation = location1
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation1?.coordinate.latitude)!,longitude: (userLocation1?.coordinate.longitude)!, zoom: 13.0)
        map1.camera = camera
        self.map1?.animate(to: camera)

        let userId = Auth.auth().currentUser?.uid
        
        self.geofire?.setLocation(location2,forKey:userId!)
        
        
        
     
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
   
   
    @IBAction func Menu(_ sender: Any) {
        self.performSegue(withIdentifier: "GotoNav", sender: self)
    }
    
    @IBAction func Cancel(_ sender: Any) {
        timer.invalidate()
        self.cancel.isHidden = true
        self.DesignView.isHidden = true
        self.emergency.isHidden = false
        self.menu.isHidden = false
        
    }
    

    @IBAction func Emergency(_ sender: Any) {
        self.cancel.isHidden = false
        self.DesignView.isHidden = false
        self.emergency.isHidden = true
        self.menu.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)

    }
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "GO", sender: self)
        
        self.DesignView.isHidden = true
        self.cancel.isHidden = true
        self.emergency.isHidden = false
        self.menu.isHidden = false
        
        
        
    }

    @IBAction func UnWindHome(_ segue:UIStoryboardSegue){
        
    }
//    @IBAction func UnWindHistory
//        (_ segue:UIStoryboardSegue){
//        
//    }
//    
//    @IBAction func CancelDrive(_ segue:UIStoryboardSegue){
//        
//    }
    

    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

 

    
   
}
