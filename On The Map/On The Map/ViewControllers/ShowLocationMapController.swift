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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var location:CLLocation?
//    var mapString : String = ""
//    var mediaURL: String = ""
    //  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Setting Region
        let center = CLLocationCoordinate2D(latitude: StudentInformation.Latitude, longitude: StudentInformation.Longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //Adding Pin
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(StudentInformation.Latitude, StudentInformation.Longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "My Location"
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    @IBAction func AddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        PostNewStudentLocation{ (success, error) in
            if success{
                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.present(tabController!, animated: true)
            } else{
                performUIUpdatesOnMain {
                    print(error!)
                }
            }
        }
    }
}
