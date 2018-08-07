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
class InformationPostingViewController: UIViewController {
    
    
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
    
    
    @IBAction func FindLocation(_ sender: Any) {
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowLocationMapController") as! ShowLocationMapController
        //mapVC.location = location
        self.navigationController?.pushViewController(mapVC, animated: true)
//        LocationManager.sharedInstance.getReverseGeoCodedLocation(address: LocationTextField.text!) {
//            (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
//                if error != nil {
//                    self.alertMessage(message: (error?.localizedDescription)!, buttonText: "OK", completionHandler: nil)
//                    return
//                }
//                guard let _ = location else {
//                    return
//                }
//            
//                print ((location?.coordinate.latitude)!)
//                print ((location?.coordinate.longitude)!)
        }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
