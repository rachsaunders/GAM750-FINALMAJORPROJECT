//
//  ProfileTableViewController.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 17/02/2021.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    
    //MARK:- IBOUTLETS
    
    @IBOutlet weak var profileCellBackground: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameAgeLabel: UILabel!
    
    @IBOutlet weak var cityCountryLabel: UILabel!
    
    
    @IBOutlet weak var diagnosesTextView: UITextView!
    
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    
    @IBOutlet weak var jobTextField: UITextField!
    
    @IBOutlet weak var educationTextField: UITextField!
    
    
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var lookingForTextField: UITextField!
    
    
    
    
    //MARK;- VIEW LIFE CYCLE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    //MARK:- IBATIONS
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 5
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return 0
//    }

  

}
