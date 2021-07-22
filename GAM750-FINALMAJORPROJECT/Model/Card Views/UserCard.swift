//
//  UserCard.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 16/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//

import Foundation
import Shuffle_iOS

class UserCard: SwipeCard {
        
    func configure(withModel model: UserCardModel) {
        content = UserCardContentView(withImage: model.image)
        footer = UserCardFooterView(withTitle: "\(model.name), \(model.age)", subTitle: model.occupation)
    }
}
