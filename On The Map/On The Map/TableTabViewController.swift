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
    
    @IBAction func LogOut(_ sender: Any) {
    }
    
}
