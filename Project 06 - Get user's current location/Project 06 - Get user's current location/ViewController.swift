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
    
    private let regionRadius: CLLocationDistance = 500
    
    private var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    
    private var tempTextString : String = ""
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
    
    @IBOutlet weak var buttonRoute: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonSearchTouchUpInside(sender: AnyObject) {
        
        /// Only Use the Location
        
        guard let location = textFieldLocation.text where !location.isEmpty else {
            print("location is Empty")
            return
        }
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location, completionHandler:  {
            placemark ,error in
            
            guard let coordinate = placemark?.first?.location?.coordinate else{
                return
            }
            
            if let _ = error {
                print(error)
                return
            }
            
            /// Update the Coordinate TextField
            self.setCoordinate(coordinate)
            /// Update the Location TextField
            self.setLocation(coordinate)
            /// Add the Annotation
            self.addAnnotation(coordinate)
        })
        
    }
    
    @IBAction func buttonClearTouchUpInside(sender: AnyObject?) {
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        textFieldLongitude.text = ""
        textFieldLatitude.text = ""
        textFieldLocation.text = ""
        
        handleTapDismissKeyboard()
        
        self.mapView.removeOverlays(self.mapView.overlays)
        
        points.removeAll()
    }
    
    
    @IBAction func buttonRouteTouchUpInside(sender: AnyObject) {

        points.append(currentCoordinate!)

        calculateDirections(points)
    }
    
    private func calculateDirections( points: [CLLocationCoordinate2D] ){
        
        for index in  0 ..< points.count - 1 {
            
            let sourcePlacemark = MKPlacemark(coordinate: points[ index ] , addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: points[ index + 1 ] , addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            /// Transport Type
            directionRequest.transportType = .Walking
            
            let directions = MKDirections(request: directionRequest)
            
            directions.calculateDirectionsWithCompletionHandler {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
                
                let route = response.routes[0]
                self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
                
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
        }
        
    }
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        /// Add Gesture
        /// Dismiss the Keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapDismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        textFieldLocation.addTarget(self, action: #selector(handleEditingDidBegin), forControlEvents: UIControlEvents.EditingDidBegin)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        initLocation()
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
    
    private func initLocation(){
        
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
        
        
        // 1. 還沒有詢問過用戶以獲得權限
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. 用戶不同意
        else if CLLocationManager.authorizationStatus() == .Denied {
            //print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. 用戶已經同意
        else if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    private func initMap(){
        
        self.mapView.delegate = self
        // 顯示自身定位位置
        self.mapView.showsUserLocation = true
        
        /// Add Gesture - Long Press
        let longPressGesture = UILongPressGestureRecognizer(target: self, action:#selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
        self.mapView.addGestureRecognizer(longPressGesture)
        
        //case None    不跟踪用户的位置
        //case  Follow   跟踪并在地图上显示用户的当前位置
        //caseFollowWithHeading  跟踪并在地图上显示用户的当前位置，地图会跟随用户的前进方向进行旋转
        //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
        self.mapView.userTrackingMode = .Follow
        
        guard let coordinate = self.currentCoordinate else{
            return
        }
        
        /// Update the Coordinate TextField
        setCoordinate(coordinate)
        /// Update the Location TextField
        setLocation(coordinate)
        
    }
    
    /// Update the Coordinate TextField
    /// - parameters:
    ///   - coordinate: Coordinate
    private func setCoordinate(currentCoordinate : CLLocationCoordinate2D){
        
        textFieldLongitude.text = "\(currentCoordinate.longitude)"
        textFieldLatitude.text = "\(currentCoordinate.latitude)"
    }
    
    /// Update the Location TextField
    /// - parameters:
    ///   - coordinate: Coordinate
    private func setLocation(currentCoordinate : CLLocationCoordinate2D){
        
        
        let getMovedMapCenter: CLLocation =  CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(getMovedMapCenter, completionHandler: {
            placemarks, error in
            
            if let error = error {
                print("Error: \(error)")
            }
            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary)
            
            // Location name
            let locationName = placeMark.addressDictionary?["Name"] as? String
            
            // City
            let city = placeMark.addressDictionary?["City"] as? String
            
            // Zip code
            let zip = placeMark.addressDictionary?["ZIP"] as? String
            
            // Country
            let country = placeMark.addressDictionary?["Country"] as? String
            
            // subLocality
            let subLocality = placeMark.addressDictionary?["SubLocality"] as? String
            
            
            self.textFieldLocation.text = "\(zip  ?? "") \(country  ?? "")\(city  ?? "")\(subLocality ?? "")\(locationName ?? "")"
            
        })
        
    }
    
    /// Add Annotation and Focus the Annotation
    /// - parameters:
    ///   - coordinate: Coordinate
    private func addAnnotation( coordinate : CLLocationCoordinate2D ) {
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = coordinate
        
        //设置点击大头针之后显示的标题
        objectAnnotation.title = "text_title_source_location".localized
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "text_subtitle_source_location".localized
        //添加大头针
        self.mapView.addAnnotation(objectAnnotation)
        
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    //==============================//
    // MARK:      Gesture
    //=============================//
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.Ended {
            let touchLocation = gestureReconizer.locationInView(self.mapView)
            let locationCoordinate = self.mapView.convertPoint(touchLocation,toCoordinateFromView: self.mapView)
            //print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            
            let coordinate = CLLocationCoordinate2D(latitude: locationCoordinate.latitude , longitude: locationCoordinate.longitude)
            
            /// Update the Coordinate TextField
            setCoordinate(coordinate)
            /// Update the Location TextField
            setLocation(coordinate)
            /// Add the Annotation
            addAnnotation(coordinate)
            
            points.append(coordinate)
        }
    }
    
    
    /// Dismiss the Keyboard
    func handleTapDismissKeyboard(){
        view.endEditing(true)
        
        guard let location = self.textFieldLocation.text else {
            return
        }
        
        let trimLocation = location.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        /// when end Editing , user never key in , then recover the location
        if trimLocation.isEmpty {
            self.textFieldLocation.text = tempTextString
            tempTextString = ""
        }
        
    }
    
    
    func handleEditingDidBegin( sender : UITextField ) {
        /// back up in temp
        tempTextString = sender.text ?? ""
        /// clear the TextField
        sender.text = ""
    }
    
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
        
        self.locationManager = nil
    }
}


extension ViewController : MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuserId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuserId)
            as? MKPinAnnotationView
        if pinView == nil {
            //创建一个大头针视图
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
            //是否显示标注
            pinView?.canShowCallout = true
            //大头针第一次显示时是否从天而降
            pinView?.animatesDrop = true
            //设置大头针描述的偏移量
            pinView?.calloutOffset = CGPoint(x:0, y: -10)
            //设置大头针颜色
            pinView?.pinTintColor = UIColor.greenColor()
            //设置大头针描述左边的控件
            pinView?.leftCalloutAccessoryView = UIButton(type: .ContactAdd)
            //设置大头针点击注释视图的右侧按钮样式
            pinView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    
    // 1. 當用戶進入一個 region
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter \(region.identifier)")
    }
    
    // 2. 當用戶退出一個 region
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit \(region.identifier)")
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        //print("地图缩放级别发送改变时")
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        //print("地图缩放完毕触法")
    }
    
    func mapViewWillStartLoadingMap(mapView: MKMapView) {
        //print("开始加载地图")
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        //print("地图加载结束")
    }
    
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        //print("地图加载失败")
    }
    
    func mapViewWillStartRenderingMap(mapView: MKMapView) {
        //print("开始渲染下载的地图块")
    }
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView, fullyRendered: Bool) {
        //print("渲染下载的地图结束时调用")
    }
    
    func mapViewWillStartLocatingUser(mapView: MKMapView) {
        //print("正在跟踪用户的位置")
    }
    
    func mapViewDidStopLocatingUser(mapView: MKMapView) {
        //print("停止跟踪用户的位置")
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        //print("更新用户的位置")
    }
    
    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError) {
        //print("跟踪用户的位置失败")
    }
    
    func mapView(mapView: MKMapView, didChangeUserTrackingMode mode: MKUserTrackingMode,
                 animated: Bool) {
        //print("改变UserTrackingMode")
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        //print("设置overlay的渲染")
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        if (overlay is MKPolyline) {
            if mapView.overlays.count == 1 {
                polylineRenderer.strokeColor =
                    UIColor.blueColor().colorWithAlphaComponent(0.75)
            } else if mapView.overlays.count == 2 {
                polylineRenderer.strokeColor =
                    UIColor.greenColor().colorWithAlphaComponent(0.75)
            } else if mapView.overlays.count == 3 {
                polylineRenderer.strokeColor =
                    UIColor.redColor().colorWithAlphaComponent(0.75)
            }
            polylineRenderer.lineWidth = 5
        }
        return polylineRenderer
    }
    
    func mapView(mapView: MKMapView, didAddOverlayRenderers renderers: [MKOverlayRenderer]) {
        //print("地图上加了overlayRenderers后调用")
    }
    
    /*** 下面是大头针标注相关 *****/
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        //print("添加注释视图")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        //print("点击注释视图按钮")
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        //print("点击大头针注释视图")
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        //print("取消点击大头针注释视图")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 didChangeDragState newState: MKAnnotationViewDragState,
                                    fromOldState oldState: MKAnnotationViewDragState) {
        //print("移动annotation位置时调用")
    }
    
}