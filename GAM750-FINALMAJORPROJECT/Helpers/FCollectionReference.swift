//
//  FCollectionReference.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 15/02/2021.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
 
    
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
    
}
