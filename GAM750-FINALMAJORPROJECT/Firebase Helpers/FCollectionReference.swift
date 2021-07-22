//
//  FCollectionReference.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 15/02/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Like
    case Match
    case Recent
    case Messages
    case Typing
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
