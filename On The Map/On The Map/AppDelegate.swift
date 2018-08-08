//
//  AppDelegate.swift
//  On The Map
//
//  Created by Manel matougui on 7/19/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locations : [[String : Any]] = []
    var firstName : String = ""/////////////////////////////////////
    
    
    func downloadLocations(downloadHandler: @escaping (_ result: [[String:Any]]?, _ error: String?) -> Void) {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
           
            guard (error == nil) else {
                downloadHandler(nil, "There was an error with your request: \(error!)")
                return
            }
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                downloadHandler(nil,"Your request returned a status code other than 2xx!")
                return
            }
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                downloadHandler(nil,"No data was returned by the request!")
                return
            }
            //Parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                downloadHandler(nil, "Could not parse the data as JSON: '\(data)'")
                return
            }
            /* 6. Use the data */
            
            guard let StudentLocations = parsedResult["results"] as? [[String: AnyObject]] else {
                downloadHandler(nil, "Cannot find key 'results' in \(parsedResult)")
                return
            }
            downloadHandler(StudentLocations, nil)
        }
        task.resume()
    }
    
    func refreshLocations(refreshHandler: @escaping (_ result: [[String:Any]]?, _ error: String?) -> Void) {
        downloadLocations() { (result, error) in
            self.locations = result!
            refreshHandler(result, error) // completionHandlerTable
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        refreshLocations() { (result, error) in
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

