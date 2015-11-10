//
//  MDG+Extensions.swift
//  MDGChat
//
//  Created by Bjarke Hesthaven Søndergaard on 21/09/15.
//  Copyright © 2015 Trifork A/S. All rights reserved.
//

import Foundation
import MDG

extension MDGPairingStatus {
    var stringValue: String {
        let value: String
        switch self {
        case .Completed:
            value = "Pairing completed"
        case .FailedGeneric:
            value = "Pairing failed generic"
        case .FailedOneTimePasscode:
            value = "One time passcode failed"
        case .OneTimePasscodeReady:
            value = "One time passcode is ready"
        case .Starting:
            value = "Pairing starting"
        case .Unknown:
            value = "Pairing status unknown"
        }
        return value
    }
}