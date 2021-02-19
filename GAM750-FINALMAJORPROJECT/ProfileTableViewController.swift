//
//  ProfileTableViewController.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 17/02/2021.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    
    //MARK:- IBOUTLETS
    
    @IBOutlet weak var profileCellBackgroundView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var diagnosesView: UIView!
    @IBOutlet weak var aboutMeView: UIView!
    
    
    
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var cityCountryLabel: UILabel!
    
    @IBOutlet weak var diagnosesTextView: UITextView!
    
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    @IBOutlet weak var jobTextField: UITextField!
    
    @IBOutlet weak var professionTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var lookingForTextField: UITextField!
    
    
    //MARK:- VARS
    
    var editingMode = false
    
    //MARK:- VIEW LIFE CYCLE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        setupBackgrounds()
        
        if FUser.currentUser() != nil {
            loadUserData()
            updateEditingMode()
        }

      
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    //MARK:- IBACTIONS
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        showEditOptions()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        showPictureOptions()
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
        editingMode.toggle()
        updateEditingMode()
        
        editingMode ? showKeyboard() : hideKeyboard()
        showSaveButton()
        
        
    }
    
    @objc func editUserData() {
        
    }
    
    //MARK:-SETUP

    private func setupBackgrounds() {
        
        profileCellBackgroundView.clipsToBounds = true
        profileCellBackgroundView.layer.cornerRadius = 100
        profileCellBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        diagnosesView.layer.cornerRadius = 10
        aboutMeView.layer.cornerRadius = 10
    
        
    }
    
    private func showSaveButton() {
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editUserData))
        
        navigationItem.rightBarButtonItem = editingMode ? saveButton : nil
        
        
    }
    
    
    //MARK:- LOAD USER DATA
    
    private func loadUserData() {
        
        let currentUser = FUser.currentUser()!
        
        // BELOW MAY NOT BE THE CORRECT CALCULATIONS
        
        nameAgeLabel.text = currentUser.username + ", \(abs(currentUser.dateOfBirth.interval(ofComponent: .year, fromDate: Date())))"
        
        
        cityCountryLabel.text = currentUser.country + "," + currentUser.city
        diagnosesTextView.text = currentUser.diagnoses != "" ? currentUser.about : "E.g. Bipolar I, PTSD..."
        aboutMeTextView.text = currentUser.about != "" ? currentUser.about : "A little bit about me..."
        jobTextField.text =  currentUser.jobTitle
        professionTextField.text = currentUser.profession
        genderTextField.text = currentUser.isMale ? "Male" : "Female"
        cityTextField.text = currentUser.city
        countryTextField.text = currentUser.country
        lookingForTextField.text = currentUser.lookingFor
        avatarImageView.image = UIImage(named: "profile")
        
        // SEE NOTE 35
        
    }
    
//MARK:- EDITING MODE
    
    func updateEditingMode() {
        
        
        aboutMeTextView.isUserInteractionEnabled = editingMode
        diagnosesTextView.isUserInteractionEnabled = editingMode
        jobTextField.isUserInteractionEnabled = editingMode
        professionTextField.isUserInteractionEnabled = editingMode
        genderTextField.isUserInteractionEnabled = editingMode
        cityTextField.isUserInteractionEnabled = editingMode
        countryTextField.isUserInteractionEnabled = editingMode
        lookingForTextField.isUserInteractionEnabled = editingMode
        
    }

    
    //MARK:- HELPERS
    
    private func showKeyboard() {
        
        self.aboutMeTextView.becomeFirstResponder()
    }
    
    private func hideKeyboard() {
        self.view.endEditing(false)
    }
    
    //MARK: - ALERTCONTROLLER
    
    
    private func showPictureOptions() {
        
        let alertController = UIAlertController(title: "Upload Picture", message: "You can change your Avatar or upload more pictures.", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Change Avatar", style: .default, handler: { (alert) in
            
           // self.showGallery(forAvatar: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Upload Pictures", style: .default, handler: { (alert) in
            
          //  self.showGallery(forAvatar: false)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    private func showEditOptions() {
        
        let alertController = UIAlertController(title: "Edit Account", message: "You are about to edit sensitive information about your account.", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Change Email", style: .default, handler: { (alert) in
            
         //   self.showChangeField(value: "Email")
        }))
        
        alertController.addAction(UIAlertAction(title: "Change Name", style: .default, handler: { (alert) in
            
          //  self.showChangeField(value: "Name")
        }))
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (alert) in
            
              //  self.logOutUser()
        }))
        
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    
    
    
}
