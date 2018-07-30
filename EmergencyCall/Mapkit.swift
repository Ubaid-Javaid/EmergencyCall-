//
//  Mapkit.swift
//  EmergencyCall
//
//  Created by Ubaid Javaid on 03/05/2018.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import Alamofire

class Mapkit: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    var timer = Timer()
    
     lazy var mapView1 = GMSMapView()
    
  
    @IBOutlet weak var designView: DesignView!
    
    @IBOutlet weak var navbtn: UIButton!
    
    @IBOutlet weak var Cancel: ButtonDesign!
    
    @IBOutlet weak var MapView: GMSMapView!
    
    var locationManager
        = CLLocationManager()
//    var latitude = 24.86136
//    var longitude = 67.07357
//    var prevlong = 67.07357
//    var prelat = 24.86136
//    var zoom:Float = 13.00

    var myLocation:CLLocationCoordinate2D?
    

    @IBOutlet weak var navButton: UIButton!
    
    @IBOutlet weak var Emergency: UIButton!
    //let emergencybutton = UIButton.self
    
    
    
  
    
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
        
//        determineMyCurrentLocation()
//
//        self.MapView.delegate = self
        
//        let camera = GMSCameraPosition.camera(withLatitude: 38.332442, longitude: -123.032234, zoom: 13.0)
//       mapView1 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        self.MapView.camera = camera
        
        
        
        
        self.designView.isHidden = true
        self.Cancel.isHidden = true

  self.Emergency.isHidden = false
        self.navbtn.isHidden = false
        
    }
    
    
//    func determineMyCurrentLocation() {
//        //locationManager = CLLocationManager()
//        locationManager.delegate = self
//
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//
//        locationManager.stopMonitoringSignificantLocationChanges()
//         locationManager.startUpdatingLocation()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//            self.locationManager.stopUpdatingLocation()
//            self.MapView.isMyLocationEnabled = true
//
//    }
//    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//
//        self.latitude = userLocation.coordinate.latitude
//        self.longitude = userLocation.coordinate.longitude
//
//
//        self.latitude = userLocation.coordinate.latitude
//        self.longitude = userLocation.coordinate.longitude
//        if(!(self.prelat==latitude) || !(prevlong == longitude)){
//            let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: zoom)
//             mapView1 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//
//MapView.camera = camera
//            MapView.animate(to: camera)
//                        print("user latitude = \(userLocation.coordinate.latitude)")
//            print("user longitude = \(userLocation.coordinate.longitude)")
//            prelat = latitude
//            prevlong = longitude
//
//        }
//
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation1 = locations.last
        let location1 = CLLocationCoordinate2D(latitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!)
        myLocation = location1
        
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!, zoom: 13.0)
     MapView.camera = camera
        self.MapView?.animate(to: camera)
        
        locationManager.stopUpdatingLocation()

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
    
  
    @IBAction func Cancelbtn(_ sender: Any) {
        timer.invalidate()
        self.designView.isHidden = true
        self.Cancel.isHidden = true
        self.navbtn.isHidden = false
        self.Emergency.isHidden = false
        
        
    }
    
    
  
    @IBAction func EmergencyBtn(_ sender: Any) {
        self.Emergency.isHidden = true
        self.designView.isHidden = false
        self.Cancel.isHidden = false
                self.navbtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)

        
    }
    
   
    @IBAction func navBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "GotoNav", sender: self)
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "GO", sender: self)
        
        self.designView.isHidden = true
        self.Cancel.isHidden = true
        self.Emergency.isHidden = false
        self.navbtn.isHidden = false

        
        
    }
//    @IBAction func UnWindHome(_ segue:UIStoryboardSegue){
//        
//    }
//    @IBAction func UnWindHistory
//        (_ segue:UIStoryboardSegue){
//        
//    }
//    
//    @IBAction func CancelDrive(_ segue:UIStoryboardSegue){
//        
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
