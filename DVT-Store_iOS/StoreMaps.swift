//
//  Locations.swift
//  DVT-Store_iOS
//
//  Created by DVT on 4/26/16.
//  Copyright © 2016 DVT. All rights reserved.
//

import UIKit
import MapKit
import LocalAuthentication

class StoreMaps : UIViewController, CLLocationManagerDelegate
{
    
    let ApiKey:String = "0ac44d4d-eb43-3e0e-fb86-ba427bee5eb4"
    var locations = [StoreLocationDetails]()
    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(initialLocation)
        print("In here")
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation();
        mapView.showsUserLocation = true
        jsonParser("GetLocations", Type: "locations")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    let initialLocation = CLLocation(latitude: -26.1227218, longitude: 28.02928)
    let regionRadius: CLLocationDistance = 1000
    
  
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        print("In here")
    }
    func jsonParser(Call : String, Type : String)
    {
        print("In here")
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlPath = "http://creed.ddns.net:14501/api/" + Call + "?ApiToken=" + self.ApiKey
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do
                {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                     print("In here")
                    
                    for object in jsonDictionary as! [NSObject]
                    {
                        let place = object.valueForKey("Place") as! String
                        let address = object.valueForKey("Address")as! String
                        let lat = object.valueForKey("Lat") as! Double
                        let long = object.valueForKey("Long") as! Double
                        print("Place" + String(place))
                        print("address " + String(address))
                        print("lat " + String(format:"%.6f", lat))
                        print("long: " + String(format:"%.6f", long))
                        let pointOnMap = StoreLocationDetails(p:place,a:address,latitude:lat,longitude:long)
                        self.locations.append(pointOnMap)
              
                    }
                    
                    dispatch_async(dispatch_get_main_queue())
                        {
                            var i = 0
                            while(self.locations.count > i  )
                            {
                                let annotaion = MKPointAnnotation()
                                let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: self.locations[i].getLat(), longitude: self.locations[i].getLong())
                                annotaion.coordinate = coordinates
                                annotaion.title = self.locations[i].getPlace()
                                annotaion.subtitle = self.locations[i].getAddress()
                                self.mapView.addAnnotation(annotaion)
                                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                                i++
                            }
                    }
                    
                }
                catch {
                    print(error)
                }
                }.resume()
        }
    }


    
}