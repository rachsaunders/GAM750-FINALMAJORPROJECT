//
//  ImageCollectionViewCell.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 19/07/2021.
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//


import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IB OUTLETS
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var backgroundPlaceholder: UIView!
    
    @IBOutlet weak var nameAgeLabel: UILabel!
    
    @IBOutlet weak var countryCityLabel: UILabel!
    
    let gradientLayer = CAGradientLayer()
    var indexPath: IndexPath!
    
    
    override class func awakeFromNib() {
    //    imageView.layer.cornerRadius = 5
     //   imageView.clipsToBounds = true
        
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if indexPath.row == 0 {
            backgroundPlaceholder.isHidden = false
            setGradientBackground()
        } else {
            backgroundPlaceholder.isHidden = true
        }
        
    }
    
    func setupCell(image: UIImage, country: String, nameAge: String, indexPath: IndexPath) {
        
        self.indexPath = indexPath
        
        imageView.image = image
        
        countryCityLabel.text = indexPath.row == 0 ? country : ""
        nameAgeLabel.text = indexPath.row == 0 ? nameAge : ""
    }
    
    
    func setGradientBackground() {
        
        gradientLayer.removeFromSuperlayer()
        
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.cornerRadius = 5
        gradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        gradientLayer.frame = self.backgroundPlaceholder.bounds

        self.backgroundPlaceholder.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
}
