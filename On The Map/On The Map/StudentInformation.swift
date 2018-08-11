//
//  StudentInformation.swift
//  On The Map
//
//  Created by Manel matougui on 8/9/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class StudentInformation {
    var FirstName: String?
    var LastName: String?
    var MapString : String?
    var MediaURL : String?
    var Latitude: Double?
    var Longitude: Double?
    
    init(data:[String:AnyObject]) {
        FirstName = data["firstName"] as? String
        LastName = data["lastName"] as? String
        MapString = data["mapString"] as? String
        MediaURL = data["mediaURL"] as? String
        Latitude = data["latitude"] as? Double
        Longitude = data["longitude"] as? Double
    }
    
    init() {}
}
