//
//  StudentModel.swift
//  On The Map
//
//  Created by Manel matougui on 8/10/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation

class StudentModel {
    var Students = [StudentInformation]()
    
    func LoadStudents (completionHandler: @escaping (_ error: String?) -> Void) {
        GetStudents { (results, error) in
            if (error != nil) {
                completionHandler(error)
            } else {
                self.Students.removeAll()
                for row in results! {
                    let student = StudentInformation(data:row)
                    self.Students.append(student)
                }
                completionHandler(nil)
            }
        }
    }
}
