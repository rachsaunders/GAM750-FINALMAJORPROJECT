//
//  RecentTableViewCell.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 20/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//



import UIKit

class RecentTableViewCell: UITableViewCell {
    
    //MARK:- IB OUTLETS
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var unreadMessageCountLabel: UILabel!
    
    @IBOutlet weak var unreadMessageBackgroundView: UIView!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        unreadMessageBackgroundView.layer.cornerRadius = unreadMessageBackgroundView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func generateCell(recentChat: RecentChat) {
        nameLabel.text = recentChat.receiverName
        lastMessageLabel.text = recentChat.lastMessage
        lastMessageLabel.adjustsFontSizeToFitWidth = true
        
        if recentChat.unreadCounter != 0 {
            self.unreadMessageCountLabel.text = "\(recentChat.unreadCounter)"
            self.unreadMessageCountLabel.isHidden = false
            self.unreadMessageBackgroundView.isHidden = false
        } else {
            self.unreadMessageCountLabel.isHidden = true
            self.unreadMessageBackgroundView.isHidden = true
        }
        
        setAvatar(avatarLink: recentChat.avatarLink)
        dateLabel.text = timeElapsed(recentChat.date)
        dateLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    private func setAvatar(avatarLink: String) {
        
        FileStorage.downloadImage(imageUrl: avatarLink) { (avatarImage) in
            if avatarImage != nil {
                self.avatarImageView.image = avatarImage?.circleMasked
            }
        }
    }
    
    func timeElapsed(_ date: Date) -> String {
        
        let seconds = Date().timeIntervalSince(date)
        print("seconds since last message", seconds)
        
        var dateText = ""
        
        if seconds < 60 {
            dateText = "Just now"
            
        } else if seconds < 60 * 60 {
            
            let minutes = Int(seconds / 60)
            let minText = minutes > 1 ? "mins" : "min"
            dateText = "\(minutes) \(minText)"
            
        } else if seconds < 24 * 60 * 60 {
            
            let hours = Int(seconds / (60 * 60))
            let hourText = hours > 1 ? "hours" : "hour"

            dateText = "\(hours) \(hourText)"
        } else {
            dateText = date.longDate()
        }
        
        return dateText
    }

}
