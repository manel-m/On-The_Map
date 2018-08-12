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
    var studentModel : StudentModel {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.studentModel
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
        return studentModel.Students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Student Cell")!
        let student = studentModel.Students[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = student.FirstName
        cell.detailTextLabel!.text = student.MediaURL
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentModel.Students[(indexPath as NSIndexPath).row]
        let app = UIApplication.shared
        if let url = URL(string: student.MediaURL!) {
            app.openURL(url)
        }
    }

    @IBAction func Refresh(_ sender: Any) {
        studentModel.LoadStudents { (error) in
            if error != nil {
                self.displayError("Could Not Load Data")
            } else{
                performUIUpdatesOnMain {
                    self.tableView.reloadData()
                }
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
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
