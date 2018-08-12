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
    var studentModel : StudentModel {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.studentModel
    }

    @IBOutlet weak var UdacityImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
  //  @IBOutlet weak var debugTextLabel: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //debugTextLabel.text = ""
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
        studentModel.LoadStudents() { (error) in
            if error != nil {
                performUIUpdatesOnMain {
                   // self.debugTextLabel.text = "Couldn't Load Student Data!"
                    self.displayError("Couldn't Load Student Data!")
                }
            } else {
                performUIUpdatesOnMain {
                    //self.debugTextLabel.text = ""
                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(controller, animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func loginPressed(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if username.isEmpty || password.isEmpty {
            //debugTextLabel.text = "Empty Email or Password."
            self.displayError("Empty Email or Password.")
        } else {
            UdacityConstants.ParameterValues.Username = username
            UdacityConstants.ParameterValues.Password = password
        }
        UdacityAuthentication { (success, error) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    //debugTextLabel.text = "Login Failed"
                    self.displayError("Invalid Email or Password")
                }
            }
        }
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
