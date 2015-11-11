//
//  ViewController.swift
//  ColorControl
//
//  Created by Simon Hem Pedersen on 08/11/15.
//  Copyright © 2015 Simon Hem Pedersen. All rights reserved.
//

import UIKit
import MDG

class ViewController: UIViewController {
    var connection: MDGPeerConnection!
    internal var messages: [Message] = []
    let client = MDGClient.sharedClient
    var peerId : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        //var client = MDGClient.sharedClient
        client.pairingDelegate = self
        MDGClient.sharedMessageStorage.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var otpLabel: UILabel!
    
    
    @IBAction func enablePairing(sender: AnyObject) {
        client.openForPairing()
    }
    
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.text = "Not connected"
        }
    }
    
    func formatOtp(otp: String) -> String {
        var formattedOtp = ""
        for (i, number) in otp.characters.enumerate() {
            formattedOtp.append(number)
            if (i % 3 == 2) && (i < otp.characters.count - 1) {
                formattedOtp += "-"
            }
        }
        return formattedOtp
    }
}

// MARK: - Actions

/*extension ViewController {
    @IBAction func openForPairing(sender: AnyObject) {
        client.openForPairing()
    }
}*/

extension ViewController: PairingDelegate {
    func pairingStateChanged(state: MDGPairingState) {
        dispatch_async(dispatch_get_main_queue()) {
            self.statusLabel.text = state.status.stringValue
            if state.status == .OneTimePasscodeReady {
                self.otpLabel.text = self.formatOtp(state.oneTimePasscode)
            }
            else {
                self.otpLabel.text = ""
            }
            if state.status == .Completed {
                self.peerId = MDGClient.sharedClient.pairings[0]
                do {
                    self.connection = try MDGClient.sharedClient.connectToPeer(self.peerId)
                }
                catch let error as NSError {
                    NSLog("ERROR connecting \(error)")
                }
                

                //MDGCore.connections()
                /*
                if let peerId = self.connection.peerId {
                    self.messages = MDGClient.sharedMessageStorage.messages.filter { $0.peerId == peerId }.reverse()
                }*/
            }
        }
    }

}

/**
 

*/


extension ViewController: MessageStorageDelegate {
    
    func addedMessage(message: Message) {
        
        if let peerId = self.connection.peerId where message.peerId == peerId {
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                if let strongSelf = self {
                    if message.text?.lowercaseString == "stop" {
                        strongSelf.view.backgroundColor = UIColor.blackColor()
                    } else if message.text?.lowercaseString == "start" {
                        strongSelf.view.backgroundColor = UIColor.whiteColor()
                    } else {
                        strongSelf.view.backgroundColor = UIColor.blackColor()
                    }
                }

                /* TODO parse message
                if message.text == "stop" {
                    if let strongSelf = self {
                        strongSelf.view.backgroundColor = UIColor.whiteColor()
                    }
                }
                */
            }
        }
    }
}
    


