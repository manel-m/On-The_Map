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
        if username.isEmpty || password.isEmpty {
            debugTextLabel.text = "Empty Email or Password."
        } else {
            UdacityConstants.ParameterValues.Username = username
            UdacityConstants.ParameterValues.Password = password
        }
        UdacityAuthentication { (success, error) in
            if success {
                self.completeLogin()
            } else {
                performUIUpdatesOnMain {
                    self.debugTextLabel.text = "Invalid Email or Password."
                }
            }
        }
        }
}
