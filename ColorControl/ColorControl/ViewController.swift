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
 int [][] morseTable =
 {
 {0,1,-1,-1,-1,-1},   // a
 {1,0,0,0,-1,-1},     // b
 {1,0,1,0,-1,-1},    // c
 {0,-1,-1,-1,-1,-1},  // e
 {0,0,1,0,-1,-1},    // f
 {1,1,0,-1,-1,-1},    // g
 };
 
 int i = 0;
 int signal = 4; // what we send
 
 int signalspace = 200;
 int shortsignal = 200;
 int longsignal = 800;
 int cmdspace = 3000;
*/


extension ViewController: MessageStorageDelegate {
    
    
    
    func addedMessage(message: Message) {
        if let peerId = self.connection.peerId where message.peerId == peerId {
            dispatch_async(dispatch_get_main_queue()) {
                    if message.text?.lowercaseString == "stop" {
                        self.view.backgroundColor = UIColor.blackColor()
                    } else if message.text?.lowercaseString == "a" {
                        NSLog("Sending a");
                        self.view.backgroundColor = UIColor.whiteColor()
                        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: "black", userInfo: nil, repeats: false)
                    } else if message.text?.lowercaseString == "b" {
                        NSLog("Sending b");
                        self.view.backgroundColor = UIColor.whiteColor()
                        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.4, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.6, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.8, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "black", userInfo: nil, repeats: false)
                    } else if message.text?.lowercaseString == "c" {
                        NSLog("Sending c");
                        self.view.backgroundColor = UIColor.whiteColor()
                        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.4, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.2, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.4, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.6, target: self, selector: "black", userInfo: nil, repeats: false)
                    } else if message.text?.lowercaseString == "e" {
                        NSLog("Sending e");
                        self.view.backgroundColor = UIColor.whiteColor()
                        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "black", userInfo: nil, repeats: false)
                    } else if message.text?.lowercaseString == "f" {
                        NSLog("Sending f");
                        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.6, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.8, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "black", userInfo: nil, repeats: false)
                    } else if message.text?.lowercaseString == "g" {
                        NSLog("Sending g");
                        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1.8, target: self, selector: "black", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "white", userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(2.2, target: self, selector: "black", userInfo: nil, repeats: false)
                    } else {
                        self.view.backgroundColor = UIColor.blackColor()
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
    
    func white() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func black() {
        self.view.backgroundColor = UIColor.blackColor()
    }
}



