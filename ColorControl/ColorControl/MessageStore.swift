//
//  MessageStorage.swift
//  MDGChat
//
//  Created by Bjarke Hesthaven Søndergaard on 02/10/15.
//  Copyright © 2015 Trifork A/S. All rights reserved.
//

import UIKit
import MDG

enum MessageSender {
    case Me, Them
}

struct Message {
    let data: NSData
    let sender: MessageSender
    let peerId: String
    
    var text: String? {
        return NSString(data: self.data, encoding: NSUTF8StringEncoding) as? String
    }
}

protocol MessageStorageDelegate {
    func addedMessage(message: Message)
}

class MessageStorage: NSObject {
    var delegate: MessageStorageDelegate?
    var messages = [Message]()
    
    func addData(data: NSData, forConnection connection: MDGPeerConnection, sender: MessageSender) {
        if let peerId = connection.peerId {
            let message = Message(data: data, sender: sender, peerId: peerId)
            self.messages.append(message)
            self.delegate?.addedMessage(message)
        }
    }
}
