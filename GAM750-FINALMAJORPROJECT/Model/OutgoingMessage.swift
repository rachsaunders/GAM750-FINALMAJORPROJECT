//
//  OutgoingMessage.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 21/07/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//


import Foundation
import UIKit

class OutgoingMessage {
    
    var messageDictionary: [String : Any]
    
    //MARK: - INITILISERS
    
    init(message: Message, text: String, memberIds: [String]) {
        
        message.type = kTEXT
        message.message = text
        
        messageDictionary = message.dictionary as! [String : Any]
    }

    
    init(message: Message, photo: UIImage, photoURL: String, memberId: [String]) {
        
        message.type = kPICTURE
        message.message = "Picture Message"
        message.photoWidth = Int(photo.size.width)
        message.photoHeight = Int(photo.size.height)
        message.mediaURL = photoURL
        
        messageDictionary = message.dictionary as! [String : Any]
    }
    
    //INIT FOR PIC MESSAGE
    
    
    class func send(chatId: String, text: String?, photo: UIImage?, memberIds: [String]) {
        
        let currentUser = FUser.currentUser()!
        
        let message = Message()
        message.id = UUID().uuidString
        message.chatRoomId = chatId
        message.senderId = currentUser.objectId
        message.senderName = currentUser.username
        
        message.sentDate = Date()
        message.senderInitials = String(currentUser.username.first!)
        message.status = kSENT
        message.message = text ?? "Picture Message"

        
        if text != nil {
            let outgoingMessage = OutgoingMessage(message: message, text: text!, memberIds: memberIds)
            outgoingMessage.sendMessage(chatRoomId: chatId, messageId: message.id, memberIds: memberIds)
        } else {

            if photo != nil {
                
                let fileName = Date().stringDate()
                let fileDirectory = "MediaMessages/Photo/" + "\(chatId)/" + "_\(fileName)" + "jpg"
                
                FileStorage.saveImageLocally(imageData: photo!.jpegData(compressionQuality: 0.6) as! NSData, fileName: fileName)
                
                FileStorage.uploadImage(photo!, directory: fileDirectory) { (imageURL) in
                    
                    if imageURL != nil {
                        let outgoingMessage = OutgoingMessage(message: message, photo: photo!, photoURL: imageURL!, memberId: memberIds)
                        outgoingMessage.sendMessage(chatRoomId: chatId, messageId: message.id, memberIds: memberIds)
                    }
                }
            }
        }
        
        
        
        PushNotificationService.shared.sendPushNotificationTo(userIds: removeCurrentUserIdFrom(userIds: memberIds), body: message.message)
        
        FirebaseListener.shared.updateRecents(chatRoomId: chatId, lastMessage: message.message)
    }
    
    
    func sendMessage(chatRoomId: String, messageId: String, memberIds: [String]) {
        
        for userId in memberIds {
            
            FirebaseReference(.Messages).document(userId).collection(chatRoomId).document(messageId).setData(messageDictionary)
        }
    }

    
    class func updateMessage(withId: String, chatRoomId: String, memberIds: [String]) {
        
        let values = [kSTATUS : kREAD] as [String : Any]
        
        for userId in memberIds {
            FirebaseReference(.Messages).document(userId).collection(chatRoomId).document(withId).updateData(values)
        }
        
    }
}
