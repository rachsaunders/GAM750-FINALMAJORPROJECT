//
//  LikeObject.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 19/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//

import Foundation

struct LikeObject {
    
    let id: String
    let userId: String
    let likedUserId: String
    let date: Date
    
    var dictionary: [String : Any] {
        return [kOBJECTID : id, kUSERID : userId, kLIKEDUSERID : likedUserId, kDATE : date]
    }
    
    func saveToFireStore() {
        
        FirebaseReference(.Like).document(self.id).setData(self.dictionary)
    }
}
