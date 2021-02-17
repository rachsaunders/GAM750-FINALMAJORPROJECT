//
//  WelcomeViewController.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 12/02/2021.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {
    
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dark Style as default so the user can see the test version text fields
        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()

  
    }
    
    //MARK:- IB ACTIONS
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if emailTextField.text != "" {

            FUser.resetPasswordFor(email: emailTextField.text!) { (error) in

                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                } else {
                    ProgressHUD.showSuccess("Please check your email!")
                }
            }

        } else {
            ProgressHUD.showError("Please insert your email address.")
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            ProgressHUD.show()
            
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error, isEmailVerified) in
                
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    
                } else if isEmailVerified {
                    
                    ProgressHUD.dismiss()
                    self.goToApp()
                    
                } else {
                    ProgressHUD.showError("Please verify your email!")
                    
                }
                
            }
            
            
        } else {
            ProgressHUD.showError("All fields are required.")
        }
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
    
    //MARK:- NAVIGATION
    
    private func goToApp() {
        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
}
