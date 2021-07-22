//
//  LikeTableViewCell.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 19/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//



import UIKit

class LikeTableViewCell: UITableViewCell {
    
    //MARK:- IB OUTLETS
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(user: FUser) {
        nameLabel.text = user.username
        setAvatar(avatarLink: user.avatarLink)
    }
    
    
    private func setAvatar(avatarLink: String) {
        
        FileStorage.downloadImage(imageUrl: avatarLink) { (avatarImage) in
            self.avatarImageView.image = avatarImage?.circleMasked
        }
    }
    
    
    
    

}
