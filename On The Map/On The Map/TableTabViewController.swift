//
//  TableTabViewController.swift
//  On The Map
//
//  Created by Manel matougui on 7/20/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
class TableTabViewController: UITableViewController {
    
    // Properties
   // var locations = [[String: Any]]()
//    var memes : [Meme]! {
//        let object = UIApplication.shared.delegate
//        let appDelegate = object as! AppDelegate
//        return appDelegate.memes
//    }
    var locations : [[String : Any]] {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.locations
    }
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       // locations = hardCodedLocationData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    // UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Student Cell")!
        let location = locations[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = location["firstName"] as? String
        cell.detailTextLabel!.text = location["mediaURL"] as? String
//        let app = UIApplication.shared
//        app.openURL(URL(string: location["mediaURL"] as! String)!)

       return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[(indexPath as NSIndexPath).row]
        let app = UIApplication.shared
        app.openURL(URL(string: location["mediaURL"] as! String)!)

    }

    
    @IBAction func Refresh(_ sender: Any) {
        self.tableView.reloadData()
    }
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    private func completeLogOut() {
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") 
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func LogOut(_ sender: Any) {
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            self.completeLogOut()
//            let range = Range(5..<data!.count)
//            let newData = data?.subdata(in: range) /* subset response data! */
//            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
//    func hardCodedLocationData() -> [[String : Any]] {
//        return  [
//            [
//                "createdAt" : "2015-02-24T22:27:14.456Z",
//                "firstName" : "Jessica",
//                "lastName" : "Uelmen",
//                "latitude" : 28.1461248,
//                "longitude" : -82.75676799999999,
//                "mapString" : "Tarpon Springs, FL",
//                "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
//                "objectId" : "kj18GEaWD8",
//                "uniqueKey" : 872458750,
//                "updatedAt" : "2015-03-09T22:07:09.593Z"
//            ], [
//                "createdAt" : "2015-02-24T22:35:30.639Z",
//                "firstName" : "Gabrielle",
//                "lastName" : "Miller-Messner",
//                "latitude" : 35.1740471,
//                "longitude" : -79.3922539,
//                "mapString" : "Southern Pines, NC",
//                "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
//                "objectId" : "8ZEuHF5uX8",
//                "uniqueKey" : 2256298598,
//                "updatedAt" : "2015-03-11T03:23:49.582Z"
//            ], [
//                "createdAt" : "2015-02-24T22:30:54.442Z",
//                "firstName" : "Jason",
//                "lastName" : "Schatz",
//                "latitude" : 37.7617,
//                "longitude" : -122.4216,
//                "mapString" : "18th and Valencia, San Francisco, CA",
//                "mediaURL" : "http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
//                "objectId" : "hiz0vOTmrL",
//                "uniqueKey" : 2362758535,
//                "updatedAt" : "2015-03-10T17:20:31.828Z"
//            ], [
//                "createdAt" : "2015-03-11T02:48:18.321Z",
//                "firstName" : "Jarrod",
//                "lastName" : "Parkes",
//                "latitude" : 34.73037,
//                "longitude" : -86.58611000000001,
//                "mapString" : "Huntsville, Alabama",
//                "mediaURL" : "https://linkedin.com/in/jarrodparkes",
//                "objectId" : "CDHfAy8sdp",
//                "uniqueKey" : 996618664,
//                "updatedAt" : "2015-03-13T03:37:58.389Z"
//            ]
//        ]
//    }
//
}
