//
//  FUser.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 12/02/2021.
//

import Foundation
import Firebase
import UIKit

class FUser: Equatable {
    
    static func == (lhs: FUser, rhs: FUser) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
    let objectId: String
    var email: String
    var username: String
    var dateOfBirth: Date
    var isMale: Bool
    var avatar: UIImage?
    var profession: String
    var jobTitle: String
    var about: String
    var diagnoses: String
    var city: String
    var country: String
    var lookingFor: String
    var avatarLink: String
    
    var likedIdArray: [String]?
    var imageLinks: [String]?
    
    let registeredDate = Date()
    var pushId: String?
    
    var userDictionary: NSDictionary {
        
        
        
        return NSDictionary(objects: [
        
        
            
            self.objectId,
            self.email,
            self.username,
            self.dateOfBirth,
            self.isMale,
            self.profession,
            self.jobTitle,
            self.about,
            self.diagnoses,
            self.city,
            self.country,
            self.lookingFor,
            self.avatarLink,
            
            self.likedIdArray ?? [],
            self.imageLinks ?? [],
            self.registeredDate,
            self.pushId ?? ""
        
        
        ],
        
        
        forKeys: [kOBJECTID as NSCopying,
                  kEMAIL as NSCopying,
                  kUSERNAME as NSCopying,
                  kDATEOFBIRTH as NSCopying,
                  kISMALE as NSCopying,
                  kPROFESSION as NSCopying,
                  kJOBTITLE as NSCopying,
                  kABOUT as NSCopying,
                  kDIAGNOSES as NSCopying,
                  kCITY as NSCopying,
                  kCOUNTRY as NSCopying,
                  kLOOKINGFOR as NSCopying,
                  kAVATARLINK as NSCopying,
                  kLIKEDIDARRAY as NSCopying,
                  kIMAGELINKS as NSCopying,
                  kREGISTEREDDATE as NSCopying,
                  kPUSHID as NSCopying
        
        
        
        
        
        
        ])
        
    }
    
    

    //MARK:- INITS
    
    init(_objectId: String, _email: String, _username: String, _city: String, _dateOfBirth: Date, _isMale: Bool, _avatarLink: String = "") {
        
        objectId = _objectId
        email = _email
        username = _username
        dateOfBirth = _dateOfBirth
        isMale = _isMale
        profession = ""
        jobTitle = ""
        about = ""
        diagnoses = ""
        city = _city
        country = ""
        lookingFor = ""
        avatarLink = _avatarLink
        likedIdArray = []
        imageLinks = []
        
        
    }
    
    init(_dictionary: NSDictionary) {
        
        objectId = _dictionary[kOBJECTID] as? String ?? ""
        email = _dictionary[kEMAIL]  as? String ?? ""
        username = _dictionary[kUSERNAME]  as? String ?? ""
        isMale = _dictionary[kISMALE] as? Bool ?? true
        profession = _dictionary[kPROFESSION]  as? String ?? ""
        jobTitle = _dictionary[kJOBTITLE] as? String ?? ""
        about = _dictionary[kABOUT] as? String ?? ""
        diagnoses = _dictionary[kDIAGNOSES] as? String ?? ""
        city = _dictionary[kCITY] as? String ?? ""
        country = _dictionary[kCOUNTRY] as? String ?? ""
        lookingFor = _dictionary[kLOOKINGFOR] as? String ?? ""
        avatarLink = _dictionary[kAVATARLINK] as? String ?? ""
        likedIdArray = _dictionary[kLIKEDIDARRAY] as? [String]
        imageLinks = _dictionary[kIMAGELINKS] as? [String]
        pushId = _dictionary[kPUSHID] as? String ?? ""
        
        
        if let date = _dictionary[kDATEOFBIRTH] as? Timestamp {
            dateOfBirth = date.dateValue()
        } else {
            dateOfBirth = _dictionary[kDATEOFBIRTH] as? Date ?? Date()
        }
        
        
        
    }
    
    //MARK: - RETURNING CURRENT USER
    
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> FUser? {
        
        if Auth.auth().currentUser != nil {
            if let userDictionary = userDefaults.object(forKey: kCURRENTUSER) {
                return FUser(_dictionary: userDictionary as! NSDictionary)
                
            }
        }
        
        return nil
        
    }
    
    
    
    //MARK:- LOGIN
    
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            
            if error == nil {
                
                if authDataResult!.user.isEmailVerified {
                    
                    FirebaseListener.shared.downloadCurrentUserFromFirebase(userId: authDataResult!.user.uid, email: email)
                    completion(error, true)
                    
                } else {
                    
                    print("Email aint verified")
                    completion(error, false)
                }
                
            } else {
                completion(error, false)
            }
            
        }
    }
    
    
    
    //MARK:- REGISTER
    
    class func registerUserWith(email: String, password: String, userName: String, city: String, isMale: Bool, dateOfBirth: Date, completion: @escaping (_ error: Error?) -> Void) {
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            
            completion(error)
            
            if error == nil {
              
                
                authData!.user.sendEmailVerification { (error) in
                    print("auth email verification sent ", error?.localizedDescription)
                }
                
                
                if authData?.user != nil {
                    
                    let user = FUser(_objectId: authData!.user.uid, _email: email, _username: userName, _city: city, _dateOfBirth: dateOfBirth, _isMale: isMale)
                    
                    user.saveUserLocally()
                }
                
            }
        }
        
    }
    
    //MARK:- RESEND LINKS

    class func resetPasswordFor(email: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                completion(error)
            })
            
            
        })
    
    
    }
    
    
    //MARK:- SAVE USER FUNCS
    
    func saveUserLocally() {
        
        userDefaults.setValue(self.userDictionary as! [String : Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }
    
    
    func saveUserToFirestore() {
        FirebaseReference(.User).document(self.objectId).setData(self.userDictionary as! [String : Any]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
    }
    
}
