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
    var students = [Student]()
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStudents()
    }

    func initStudents() {
        students.append(Student(name: "Malak Matougui", url: "http://malak.matougui.com"))
        students.append(Student(name: "Malak Matougui", url: "http://malak.matougui.com"))
        students.append(Student(name: "Malak Matougui", url: "http://malak.matougui.com"))
        //let student = students[0]
        //let name = student.Name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    // UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Student Cell")!
        let student = students[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = student.Name
        cell.detailTextLabel!.text = student.Url
       return cell
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
    
}
