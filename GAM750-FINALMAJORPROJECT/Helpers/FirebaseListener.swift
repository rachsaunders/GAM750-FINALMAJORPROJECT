//
//  FirebaseListener.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 15/02/2021.
//

import Foundation
import Firebase

class FirebaseListener {
    
    static let shared = FirebaseListener()
    
    private init() {
        
    }
    
    
    //MARK:- FUser
    
    func downloadCurrentUserFromFirebase(userId: String, email: String) {
        
        FirebaseReference(.User).document(userId).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                return
            }
            
            if snapshot.exists {
                
                let user = FUser(_dictionary: snapshot.data() as! NSDictionary)
                user.saveUserLocally()
                
            } else {
                // first login
                
                if let user = userDefaults.object(forKey: kCURRENTUSER) {
                    FUser(_dictionary: user as! NSDictionary).saveUserToFirestore()
                }
            }
            
            
            
        }
        
    }
    
    
    
    
    
}
