//
//  RegisterViewController.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 12/02/2021.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK:- VARIABLES
    
    var isMale = true
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()
 
    }
    

    //MARK:- IB ACTIONS
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        
        if isTextDataImputed() {
            if passwordTextField.text! == confirmPasswordTextField.text! {
                registerUser()
            } else {
                ProgressHUD.showError("Passwords don't match!")
            }
          
        } else {
            ProgressHUD.showError("Please fill in all fields")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func genderSegmentValueChanged(_ sender: UISegmentedControl) {
        isMale = sender.selectedSegmentIndex == 0 ? true : false
        
    }
    
    
    //MARK:- SETUP
    
    private func setupBackgroundTouch() {
        
        backgroundImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        backgroundImageView.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func backgroundTap() {
        dismissKeyboard()
    }
    
    //MARK:- HELPERS
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    
    private func isTextDataImputed() -> Bool {
    
        return usernameTextField.text != "" && emailTextField.text != "" && cityTextField.text != "" && dateOfBirthTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""
        
    }
    
    //MARK:- REGISTER USER
    private func registerUser() {
        
        ProgressHUD.show()
        
        FUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!, userName: usernameTextField.text!, city: cityTextField.text!, isMale: isMale, dateOfBirth: Date(), completion: { error in
            
    
            
            if error == nil {
                ProgressHUD.showSuccess("Verification email sent!")
                self.dismiss(animated: true, completion: nil)
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
            

        })
        
        
    }
}
