//
//  MapTabViewController.swift
//  On The Map
//
//  Created by Manel matougui on 7/20/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
class MapTabViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func Refresh(_ sender: Any) {
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
