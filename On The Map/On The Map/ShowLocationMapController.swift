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
    var location:CLLocation?
    var mapString : String = ""
    var mediaURL: String = ""
    //  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Setting Region
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //Adding Pin
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "My Location"
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    @IBAction func AddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        postNewStudentLocation()
        let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        self.present(tabController!, animated: true)
    }
    
    func postNewStudentLocation (){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let firstName = "manel"//self.appDelegate.firstName
        print(firstName)
        let latitude = location?.coordinate.latitude
        print(latitude!)
        let longitude = location?.coordinate.longitude
        print(longitude!)
        print(mapString)
        print(mediaURL)
        
        let body = "{\"uniqueKey\": \"1244\", \"firstName\": \"\(firstName)\", \"lastName\": \"\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\":\(latitude!), \"longitude\": \(longitude!)}"
        print(body)
        request.httpBody = body.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error posting new student location: \(error!)")
                return
            }
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!: ")
                return
            }
            guard let data = data else {
                displayError ("No posting new student location data was returned!")
                return
            }
            //print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
}
