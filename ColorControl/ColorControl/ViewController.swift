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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client.pairingDelegate = self

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
    
    let client = MDGClient.sharedClient
    
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
        }
    }

}
    
    


