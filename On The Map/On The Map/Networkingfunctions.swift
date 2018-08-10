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
