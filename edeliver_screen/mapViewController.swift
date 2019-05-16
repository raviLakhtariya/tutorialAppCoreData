//
//  mapViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 27/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation






class mapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
     let myAnnotation: MKPointAnnotation = MKPointAnnotation()

    @IBOutlet weak var getRoute: UIButton!
    var locationManager = CLLocationManager()
    
    var location = CLLocation()
   var addressString : String = ""
    
 var titles : String? = "mylocation"
    var subtitles : String? = ""
    let request = MKDirectionsRequest()
    var marg = String()
    var country = String()
    var city = String()
    var throughfarea = String()
    var subthroughfare = String()
    var postalcodes = String()
    var administrativearea = String()
    
    @IBOutlet weak var mapView: MKMapView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getRoute.addTarget(self, action: #selector(getAddressroute), for: UIControlEvents.touchUpInside)
        

        
        self.mapView.isHidden = false
        self.mapView.delegate = self
        
        initializeTheLocationManager()
        self.mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    
       
    }
    func getAddressroute(sender:UIButton){
        
        
              request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.add(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }

    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }


    //it is initialize locationmanager delagate
    func initializeTheLocationManager() {
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    //it display inform postalcode and address
    func displayLocationInfo(placemark:CLPlacemark){
        if placemark != nil {
            locationManager.stopUpdatingLocation()
            print(placemark.locality ?? "nil")
            print(placemark.postalCode ?? "nil")
            print(placemark.administrativeArea ?? "nil")
        }
    }
    
    
    //didupdate userlocation method it create pinannotation object and create pin
    //update last location
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
        let userLocation = mapView.userLocation
        self.mapView.isZoomEnabled = true
        
        let centerLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate:centerLocation))
        
        
        
        let mapspan = MKCoordinateSpanMake(0.01, 0.01)
        let mapregion = MKCoordinateRegionMake(centerLocation, mapspan)
        self.mapView.setRegion(mapregion, animated: true)
        
       
       
    
        self.getAddresses(longitude:userLocation.coordinate.longitude, lattitude: userLocation.coordinate.latitude)
       
       
        
              myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        myAnnotation.subtitle = "click here"
    
        mapView.addAnnotation(myAnnotation)
    }
 
    //it show address
    
    func setAddress(){
   
        if marg != nil {
            self.addressString = self.addressString + marg + ","
            
        }
        if throughfarea != nil {
            
            self.addressString = self.addressString + throughfarea + ", "
        }

        if administrativearea != nil {
            self.addressString = self.addressString + administrativearea + ","
            
        }
       
        if city != nil {
            self.addressString = self.addressString + city + ", "
        }
        
        if postalcodes != nil {
            self.addressString = self.addressString + postalcodes + " "
        }
        
        print(self.addressString)
        
    


    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        switch newState {
        case .starting:
            view.dragState = .dragging
            
        case .ending, .canceling:
            view.dragState = .none
        default: break
        }
        if newState == MKAnnotationViewDragState.dragging {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt!)
            myAnnotation.coordinate = droppedAt!
            getAddresses(longitude: (droppedAt?.longitude)!, lattitude: (droppedAt?.latitude)!)
            myAnnotation.title = "\(titles!)"
           myAnnotation.subtitle = "\(subtitles!)"
            
            
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (droppedAt?.latitude)!, longitude: (droppedAt?.longitude)!)))

           
            
        }
    }
    func getAddresses(longitude:CLLocationDegrees, lattitude: CLLocationDegrees){
        let location = CLLocation(latitude: lattitude, longitude: longitude)
        
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = (placemarks)! as [CLPlacemark]?
                
                if (pm?.count)! > 0 {
                    let pm = placemarks![0]
               
                    if pm.subLocality == nil{
                        
                        self.marg = ""
                        self.titles = ""
                        
                    }else{
                        
                        self.marg = pm.subLocality!
                        self.titles = pm.subLocality!
                    }
                    if pm.thoroughfare == nil{
                        
                        self.subtitles = ""
                        self.throughfarea = ""
                 
                    }else{
                      
                        self.subtitles = pm.thoroughfare!
                        self.throughfarea = pm.thoroughfare!
                    
                    }
                    if pm.administrativeArea == nil{
                       
                        self.administrativearea = ""
                    }
                    else{
                       
                        self.administrativearea = pm.administrativeArea!
                    }
                    
                    if pm.locality == nil{
                        
                        self.city = ""
                        self.titles = ""
                        
                    }else{
                        
                        self.city = pm.locality!
                      
                    }

                    if pm.postalCode == nil{
                    self.postalcodes = ""
                    }else{
                        self.postalcodes = pm.postalCode!
                    }
                    print(pm.subLocality as Any)
                    print(pm.thoroughfare as Any)
                    print(pm.administrativeArea as Any)
                    
                    print(pm.locality as Any)
                    print(pm.postalCode as Any)
                    
                    
                    
                }
                })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
    
        if annotation is MKPointAnnotation{
            
            let pinAnnotationView = MKPinAnnotationView(annotation: myAnnotation, reuseIdentifier: "myPin")
    
            pinAnnotationView.pinTintColor = .red
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            
            pinAnnotationView.animatesDrop = true
            return pinAnnotationView
        }
    
        return nil
    }
    

    @IBAction func setbutton(_ sender: Any) {
        
        self.setAddress()
        
        
        
        
        
        
        
        
        
        
       self.alert(addressSstring: addressString)
    }
    
    func alert(addressSstring:String){
        let alertCntrl = UIAlertController.init(title:"Your Address", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertactionOK = UIAlertAction.init(title: "conform", style: UIAlertActionStyle.default) { (UIAlertAction) in
            
            
      
          self.performSegue(withIdentifier:"unwind", sender: self)
          
                              
        }
        let alertactionCancel = UIAlertAction.init(title: "cancel", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertCntrl.addAction(alertactionOK)
        alertCntrl.addAction(alertactionCancel)
        present(alertCntrl, animated: true, completion: nil)
    }
    
    
}
