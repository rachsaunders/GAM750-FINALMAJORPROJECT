//
//  NewMatchCollectionViewCell.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 20/07/2021.
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//


import UIKit

class NewMatchCollectionViewCell: UICollectionViewCell {
    
    
    //MARK:- IB OUTLETS
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func awakeFromNib() {
        
        hideActivityIndicator()
    }
    
    
    func setupCell(avatarLink: String) {
        
        showActivityIndicator()
        
        self.avatarImageView.image = UIImage(named: "profile")
        
        FileStorage.downloadImage(imageUrl: avatarLink) { (avatarImage) in
            self.hideActivityIndicator()
            self.avatarImageView.image = avatarImage?.circleMasked
        }
    }
    
    
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

    
    
}
