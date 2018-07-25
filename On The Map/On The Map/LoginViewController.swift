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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    private func completeLogin() {
        if usernameTextField.text == "n" && passwordTextField.text == "y" {
            self.debugTextLabel.text = ""
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "UdacityTabBarController") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        } else {
            debugTextLabel.text = "nnnnnnnnnnnnnn"
            
        } }
    

    @IBAction func loginPressed(_ sender: Any) {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty."
        } else {
            completeLogin()
            }
        
        }

}
