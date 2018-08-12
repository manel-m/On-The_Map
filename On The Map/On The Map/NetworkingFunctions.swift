//
//  Networkingfunctions.swift
//  On The Map
//
//  Created by Manel matougui on 8/9/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
// Authentication
func UdacityAuthentication (completionHandler: @escaping (_ success: Bool, _ error: String?) -> Void)  {
    //Set the parameters, Build the URL, Configure the request
    var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = ("{\"udacity\": {\"username\": \""+UdacityConstants.ParameterValues.Username+"\", \"password\": \""+UdacityConstants.ParameterValues.Password+"\"}}").data(using: .utf8)
    // Make the request
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        // Guard: was there an error?
        guard (error == nil) else {
            completionHandler(false, "Login Failed")
            return
        }
      
        /* GUARD: Did we get a successful 2XX response? */
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            completionHandler(false, "Your request returned a status code other than 2xx!")
            return
        }
        //GUARD: Was there any data returned?
        guard let data = data else {
            completionHandler(false, "No login data was returned by the request!")
            return
        }
        let range = Range(5..<data.count)
        let newData = data.subdata(in: range) /* subset response data! */
        // Parse the data *
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
        } catch {
            completionHandler(false, "Could not parse the login data as JSON")
            return
        }
        // Use the data
        guard let results = parsedResult["account"] as? [String: AnyObject] else {
            completionHandler(false, "Cannot find key 'account' in login parsed results")
            return
        }
        // save results["key"] in constants
        UdacityConstants.ResponseValues.AccountKey = results["key"] as! String
        completionHandler(true, nil)
    }
    task.resume()
}
// delete session
func DeleteSession (){
     //Build the URL, Configure the request
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
        // if an error occurs, print it and re-enable the UI
        func displayError(_ error: String) {
            print(error)
        }
        // Guard: was there an error?
        guard (error == nil) else {
            displayError("There was an error with  request")
            return
        }
        // Guard: Is there a succesful HTTP 2XX response?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            displayError("Your request returned a status code other than 2xx!")
            return
        }
        // Guard: any data returned?
        guard let data = data else {
            displayError("No data was returned by the request!")
            return
        }
        //   let range = Range(5..<data!.count)
        //   let newData = data?.subdata(in: range) /* subset response data! */
    }
    task.resume()
    
}
//get students data
func GetStudents(completionHandler: @escaping (_ result: [[String:AnyObject]]?, _ error: String?) -> Void) {
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    //Make the request
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        // Guard: was there an error?
        guard (error == nil) else {
            completionHandler(nil, "There was an error with your request: \(error!)")
            return
        }
        // Guard: Is there a succesful HTTP 2XX response?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            completionHandler(nil, "Your request returned a status code other than 2xx!")
            return
        }
        // Guard: any data returned?
        guard let data = data else {
            completionHandler(nil, "No data was returned by the request!")
            return
        }
        //Parse the data
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
        } catch {
            completionHandler(nil, "Could not parse student locations data as JSON")
            return
        }
        //Use the data
        guard let Students = parsedResult["results"] as? [[String: AnyObject]] else {
            completionHandler(nil, "Cannot find key 'results' in student locations")
            return
        }
        completionHandler(Students, nil)
    }
    task.resume()
}
// add new student
func PostNewStudentLocation(student: StudentInformation, completionHandler: @escaping (_ success: Bool, _ error: String?) -> Void) {
    //Build the URL, Configure the request
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
    request.httpMethod = "POST"
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let firstName = student.FirstName!
    let latitude = student.Latitude! //location?.coordinate.latitude
    let longitude = student.Longitude! //location?.coordinate.longitude
    let mapString = student.MapString!
    let mediaURL = student.MediaURL!
    let body = "{\"uniqueKey\": \"1244\", \"firstName\": \"\(firstName)\", \"lastName\": \"\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\":\(latitude), \"longitude\": \(longitude)}"
    request.httpBody = body.data(using: .utf8)
    // Make the request
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        /* GUARD: Was there an error? */
        guard (error == nil) else {
            completionHandler(false,"There was an error posting new student location: \(error!)" )
            return
        }
        /* GUARD: Did we get a successful 2XX response? */
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            completionHandler(false,"Your request returned a status code other than 2xx!: " )
            return
        }
        guard let data = data else {
            completionHandler(false,"No posting new student location data was returned!" )
            return
        }
        completionHandler(true,nil)
    }
    task.resume()
    
}
