//
//  PhotoMessage.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 21/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//

import Foundation
import MessageKit


class PhotoMessage: NSObject, MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    init(path: String) {
        self.url = URL(fileURLWithPath: path)
        self.placeholderImage = UIImage(named: "photoPlaceholder")!
        self.size = CGSize(width: 240, height: 240)
    }
    
    
    
}
