//
//  RegisterViewController.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 12/02/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentOutlet: UISegmentedControl!
    
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    

    //MARK:- IB ACTIONS
    @IBAction func backButtonPressed(_ sender: Any) {
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    
}
