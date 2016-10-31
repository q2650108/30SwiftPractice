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
        
        
        
//        guard let textFieldLongitude.text?.isEmpty || textFieldLatitude.text?.isEmpty else {
//            
//            let alertController = UIAlertController(title: "Eorror", message:
//                "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//            
//            self.presentViewController(alertController, animated: true, completion: nil)
//            return
//        }
//        
//        
//        let newLocation = CLLocationCoordinate2D(latitude: , longitude: -73.984472)
        
        
    }
    
    @IBAction func buttonClearTouchUpInside(sender: AnyObject) {
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
            //("Location services were previously denied. Please enable location services for this app in Settings.")
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
        
        setCoordinate(coordinate)
        setLocation(coordinate)
        
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = coordinate
        
        //设置点击大头针之后显示的标题
        objectAnnotation.title = "現在位置"
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "就是現在位置"
        //添加大头针
        self.mapView.addAnnotation(objectAnnotation)
        
        //        let geoCoder = CLGeocoder()
        //
        //        geoCoder.geocodeAddressString("板橋圖書館", completionHandler:  {
        //            placemark ,error in
        //
        //            guard let coordinate = placemark?.first?.location?.coordinate else{
        //                return
        //            }
        //
        //
        //            if let _ = error {
        //                print(error)
        //                return
        //            }
        //
        //
        //            let annotation = MKPointAnnotation()
        //            annotation.title = "test place"
        //            annotation.subtitle =  "Waikiki Gateway Park"
        //            annotation.coordinate = coordinate
        //
        //            //self.mapView.mapType
        //            //  MKMapType.Standard ：标准地图
        //            //  MKMapType.Satellite ：卫星地图
        //            //  MKMapType.Hybrid ：混合地图
        //
        //            self.mapView.showAnnotations([annotation], animated: true)
        //            self.mapView.selectAnnotation(annotation, animated: true)
        //            self.mapView.setRegion(self.getCoordinateRegion(coordinate), animated: true)
        //
        //            // 5. 繪製一個圓圈圖形（用於表示 region 的範圍）
        //            let circle = MKCircle(centerCoordinate: coordinate, radius: self.regionRadius)
        //            self.mapView.addOverlay(circle)
        //
        //        })
        //
        //
        
        
    }
    
    private func setCoordinate(currentCoordinate : CLLocationCoordinate2D){
        
        textFieldLongitude.text = "\(currentCoordinate.longitude)"
        textFieldLatitude.text = "\(currentCoordinate.latitude)"
    }
    
    private func setLocation(currentCoordinate : CLLocationCoordinate2D){
        
        
        let getMovedMapCenter: CLLocation =  CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(getMovedMapCenter, completionHandler: {
            placemarks, error in
            
            
            if let _ = error  {
                print(error)
                return
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
    
    
    private func  getCoordinateRegion(coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion{
        return MKCoordinateRegionMakeWithDistance(coordinate,
                                                  self.regionRadius * 2.0,
                                                  self.regionRadius * 2.0)
    }
    
    
    //==============================//
    // MARK:      Gesture
    //=============================//
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.Ended {
            let touchLocation = gestureReconizer.locationInView(self.mapView)
            let locationCoordinate = self.mapView.convertPoint(touchLocation,toCoordinateFromView: self.mapView)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            return
        }
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    //==============================//
    // MARK:      Gesture
    //=============================//
    
    /// Dismiss the Keyboard
    func handleTapDismissKeyboard(){
        view.endEditing(true)
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
        locationManager = nil
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
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.redColor()
        circleRenderer.lineWidth = 1.0
        return circleRenderer
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