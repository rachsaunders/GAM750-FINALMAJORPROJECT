//
//  IncomingMessage.swift
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
import Firebase

class IncomingMessage {
    
    var messageCollectionView: MessagesViewController
    
    init(collectionView_: MessagesViewController) {
        messageCollectionView = collectionView_
    }
    
    func createMessage(messageDictionary: [String: Any]) -> MKMessage? {
        
        let message = Message(dictionary: messageDictionary)
        let mkMessage = MKMessage(message: message)
        
        if message.type == kPICTURE {

            let photoItem = PhotoMessage(path: message.mediaURL)
            mkMessage.photoItem = photoItem
            mkMessage.kind = MessageKind.photo(photoItem)
            
            FileStorage.downloadImage(imageUrl: messageDictionary[kMEDIAURL] as? String ?? "") { (image) in

                mkMessage.photoItem?.image = image
                DispatchQueue.main.async {
                    self.messageCollectionView.messagesCollectionView.reloadData()
                }
            }
        }
        
        return mkMessage
    }
    
    
}
