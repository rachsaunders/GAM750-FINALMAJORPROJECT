//
//  MatchObject.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 19/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//

import Foundation

struct MatchObject {
    
    let id: String
    let memberIds: [String]
    let date: Date
    
    var dictionary: [String : Any] {
        return [kOBJECTID : id, kMEMBERIDS : memberIds, kDATE : date]
    }
    
    func saveToFireStore() {
        
        FirebaseReference(.Match).document(self.id).setData(self.dictionary)
    }
}
