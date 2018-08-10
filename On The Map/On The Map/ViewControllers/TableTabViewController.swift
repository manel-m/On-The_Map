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
    var locations : [[String : Any]] {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.locations
    }
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[(indexPath as NSIndexPath).row]
        let app = UIApplication.shared
        if let url = URL(string: location["mediaURL"] as! String) {
            app.openURL(url)
        }
    }

    @IBAction func Refresh(_ sender: Any) {
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.refreshLocations() { (result, error) in
                performUIUpdatesOnMain {
                    self.tableView.reloadData()
                }
            }
    }
    
    @IBAction func LogOut(_ sender: Any) {
        DeleteSession()
        performUIUpdatesOnMain {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(controller, animated: true, completion: nil)
        }
        
}
}
