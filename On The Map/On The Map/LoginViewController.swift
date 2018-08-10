//
//  ViewController.swift
//  On The Map
//
//  Created by Manel matougui on 7/19/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{
    
    // MARK: Outletss
    
    @IBOutlet weak var UdacityImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugTextLabel.text = ""
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Email" || textField.text == "Password" {
            textField.text = ""
        }
    }
    // Login
    private func completeLogin() {
        performUIUpdatesOnMain {
            self.debugTextLabel.text = ""
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        }
    }

    @IBAction func loginPressed(_ sender: Any) {
        
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        self.appDelegate.firstName = username
        if username.isEmpty || password.isEmpty {
            debugTextLabel.text = "Empty Email or Password."
        } else {
            UdacityAuthentication(username, password)
            }
        }
   // Authentication
    func UdacityAuthentication (_ username: String, _ password: String) {
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = ("{\"udacity\": {\"username\": \""+username+"\", \"password\": \""+password+"\"}}").data(using: .utf8)
        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
                performUIUpdatesOnMain {
                    self.debugTextLabel.text = "Invalid Email or Password."
                }
            }
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!: ")
                return
            }
            
             //GUARD: Was there any data returned?
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
//            let range = Range(5..<data.count)
//            let newData = data.subdata(in: range) /* subset response data! */
//            print(String(data: newData, encoding: .utf8)!)
            
            self.completeLogin()
        }
        task.resume()
        
    }



}
