//
//  ShowLocationMapController.swift
//  On The Map
//
//  Created by Manel matougui on 8/6/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ShowLocationMapController: UIViewController, MKMapViewDelegate {
    
    // Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBar: UINavigationItem!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var student:StudentInformation?

    //  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Setting Region
        let center = CLLocationCoordinate2D(latitude: (student?.Latitude)!, longitude: (student?.Longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //Adding Pin
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake((student?.Latitude)!, (student?.Longitude)!)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "My Location"
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    @IBAction func AddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        PostNewStudentLocation(student:student!) { (success, error) in
            performUIUpdatesOnMain {
                self.activityIndicator.startAnimating()
            }
            
            if success{
                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.present(tabController!, animated: true)
            } else{
                performUIUpdatesOnMain {
                    print(error!)// handle error
                }
            }
        }
    }
}
