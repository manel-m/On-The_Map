//
//  InformationPostingViewController.swift
//  On The Map
//
//  Created by Manel matougui on 7/24/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class InformationPostingViewController: UIViewController, UITextFieldDelegate {
    
    // Properties
    @IBOutlet weak var WorldIconImageView: UIImageView!
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var UrlTextField: UITextField!
    @IBOutlet weak var FindLocationButton: UIButton!
    //@IBOutlet weak var debugTextLabel: UILabel!
    
    lazy var geocoder = CLGeocoder()
    
    //UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Enter a Location" || textField.text == "Enter a Website" {
            textField.text = ""
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //debugTextLabel.text = ""
        LocationTextField.delegate = self
        UrlTextField.delegate = self
    }
    
    
    @IBAction func FindLocation(_ sender: Any) {
        let location = LocationTextField.text!
        let Url = UrlTextField.text!
        if location.isEmpty || Url.isEmpty {
            //debugTextLabel.text = "Location or Website Empty."
            self.displayError("Location or Website Empty.")
        } else {
            geocoder.geocodeAddressString(LocationTextField.text!) {
                (placemarks, error) in
                if error != nil {
                    //self.debugTextLabel.text = "Location Not Found"
                    self.displayError("Location Not Found")
                    return
                }
                
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowLocationMapController") as! ShowLocationMapController
                    
                    let student = StudentInformation()
                    student.FirstName = "manel" //UdacityConstants.ParameterValues.Username
                    student.MapString = self.LocationTextField.text!
                    student.MediaURL = self.UrlTextField.text!
                    student.Latitude = location.coordinate.latitude
                    student.Longitude = location.coordinate.longitude
                    
                    mapVC.student = student
                    
                    self.navigationController?.pushViewController(mapVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
