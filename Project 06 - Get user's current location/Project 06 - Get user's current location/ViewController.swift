//
//  ViewController.swift
//  Project 06 - Get user's current location
//
//  Created by SHUN on 10/21/16.
//  Copyright © 2016 q2650108. All rights reserved.
//


import MapKit
import CoreLocation
import UIKit

class ViewController: UIViewController {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var locationManager : CLLocationManager!
    
    private var currentCoordinate : CLLocationCoordinate2D?
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    
    @IBOutlet weak var labelLongitude: UILabel!
    
    @IBOutlet weak var textFieldLongitude: UITextField!
    
    @IBOutlet weak var labelLatitude: UILabel!
    
    @IBOutlet weak var textFieldLatitude: UITextField!
    
    @IBOutlet weak var labelLocation: UILabel!
    
    @IBOutlet weak var textFieldLocation: UITextField!
    
    @IBOutlet weak var buttonSearch: UIButton!
    
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonSearchTouchUpInside(sender: AnyObject) {
    }
    
    @IBAction func buttonClearTouchUpInside(sender: AnyObject) {
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        getLocation()
        initMap()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Hide the Status Bar
    override func prefersStatusBarHidden () -> Bool {
        return true
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initUI(){
        
    }
    
    private func getLocation(){
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //        kCLLocationAccuracyBestForNavigation：精確度最高，適用於導航的定位。
        //        kCLLocationAccuracyBest：精確度高。
        //        kCLLocationAccuracyNearestTenMeters：精確度 10 公尺以內。
        //        kCLLocationAccuracyHundredMeters：精確度 100 公尺以內。
        //        kCLLocationAccuracyKilometer：精確度 1 公里以內。
        //        kCLLocationAccuracyThreeKilometers：精確度 3 公里以內。
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        // 取得自身定位位置的精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //manager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            // if location Services Enabled
            locationManager.startUpdatingLocation()
            print("Location Stary")
        }
        
    }
    
    private func initMap(){
        
        setCoordinate()
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString("台灣新北市土城區立德路", completionHandler:  {
            placemark ,error in
            
            print(error)
            
            let annotation = MKPointAnnotation()
            annotation.title = "test place"
            annotation.coordinate = (placemark?.first?.location?.coordinate)!
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
            
        })
        
        
        
    }
    
    private func setCoordinate(){
        
        guard let coordinate = self.currentCoordinate else{
            return
        }
        
        textFieldLongitude.text = "\(coordinate.longitude)"
        textFieldLatitude.text = "\(coordinate.latitude)"
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
}

//==============================//
// MARK:      CLLocationManagerDelegate
//=============================//

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{
            return
        }
        
        //"经度：\(location.coordinate.longitude)"
        //"纬度：\(location.coordinate.latitude)"
        //"海拔：\(location.altitude)"
        //"水平精度：\(currLocation.horizontalAccuracy)"
        //"垂直精度：\(currLocation.verticalAccuracy)"
        //"方向：\(currLocation.course)"
        //"速度：\(currLocation.speed)"
        
        // Save Current coordinate
        currentCoordinate = location.coordinate
        
        initMap()
        locationManager = nil
    }
}


