//
//  MapTabViewController.swift
//  On The Map
//
//  Created by Manel matougui on 7/20/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class MapTabViewController : UIViewController, MKMapViewDelegate {
    
    // Properties
    @IBOutlet weak var mapView: MKMapView!
    var locations : [[String : Any]] {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.locations
    }
    //  Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        print("MAP APPEARED")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        createAnnotations(locations: appDelegate.locations)
    }
    
    func createAnnotations(locations: [[String: Any]]) {
        var annotations = [MKPointAnnotation]()
        for dictionary in locations {
            
            if let latitude = dictionary["latitude"] as? Double, let longitude = dictionary["longitude"] as? Double, let firstName = dictionary["firstName"] as? String, let lastName = dictionary["lastName"] as? String, let mediaURL = dictionary["mediaURL"] as? String {
                // This is a version of the Double type.
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(firstName) \(lastName)"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
        }
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                //app.openURL(URL(string: toOpen)!)
                if let url = URL(string: toOpen) {
                    app.openURL(url)
                }
            }
        }
    }
    
    private func completeLogOut() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func Refresh(_ sender: Any) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.refreshLocations() { (result, error) in
            print("DATA REFRESHED")
            performUIUpdatesOnMain {
                let old = self.mapView.annotations
                self.mapView.removeAnnotations(old)
                self.createAnnotations(locations:self.locations)
            }
        }
    }
    
    @IBAction func LogOut(_ sender: Any) {
        DeleteSession()
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(controller, animated: true, completion: nil)
        }
    }
}
