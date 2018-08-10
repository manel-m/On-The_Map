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
    @IBOutlet weak var debugTextLabel: UILabel!
    
    
    func alertMessage(message:String,buttonText:String,completionHandler:(()->())?) {
        let alert = UIAlertController(title: "Location", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
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
        debugTextLabel.text = ""
        LocationTextField.delegate = self
        UrlTextField.delegate = self
    }
    
    
    @IBAction func FindLocation(_ sender: Any) {
        let location = LocationTextField.text!
        let Url = UrlTextField.text!
        if location.isEmpty || Url.isEmpty {
            debugTextLabel.text = "Location or Website Empty."
        } else {
            LocationManager.sharedInstance.getReverseGeoCodedLocation(address: LocationTextField.text!) {
            (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
                if error != nil {
                    self.debugTextLabel.text = "Location Not Found"
                    return
                }
                guard let _ = location else {
                    return
                }
                let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowLocationMapController") as! ShowLocationMapController
                mapVC.location = location
                mapVC.mapString = self.LocationTextField.text!
                mapVC.mediaURL = self.UrlTextField.text!
                self.navigationController?.pushViewController(mapVC, animated: true)
                    }
                }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        }
    
}
