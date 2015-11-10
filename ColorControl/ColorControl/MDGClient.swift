//
//  MDGClient.swift
//  MDGChat
//
//  Created by Bjarke Hesthaven Søndergaard on 21/09/15.
//  Copyright © 2015 Trifork A/S. All rights reserved.
//

import UIKit
import MDG

let PeerNamesKey = "PeerNamesKey"
public let UserEmailKey = "shipit@jaoo.dk"


public protocol PairingDelegate: NSObjectProtocol {
    func pairingStateChanged(state: MDGPairingState)
}

public protocol ConnectionDelegate: NSObjectProtocol {
    func routingStatusChanged(connection: MDGPeerConnection, status: MDGRoutingStatus)
}

public class MDGClient: NSObject {
    public static let sharedClient = MDGClient()
    let messageStorage = MessageStorage()
    private let core = MDGCore.sharedCore()
    private var properties: [String: String] {
        var props = [String: String]()
        if let userEmail = NSUserDefaults.standardUserDefaults().stringForKey(UserEmailKey) {
            props["client_email"] = userEmail
        }
        return props
    }
    
    public var pairings: [String] {
        return core.pairings
    }
    
    private var peerNames: [String: String] = (NSUserDefaults.standardUserDefaults().objectForKey(PeerNamesKey) as? [String: String]) ?? [String: String]()
    
    public weak var pairingDelegate: PairingDelegate?
    public weak var connectionDelegate: ConnectionDelegate?
    
    private override init() {
        super.init()
        core.delegate = self
    }
    
    public func connect() {
        do {
            try core.connect(self.properties)
        }
        catch {
            
        }
    }
    
    public func disconnect() {
        try! core.disconnect()
    }
    
    public func reconnect() {
        self.disconnect()
        self.connect()
    }
    
    public func pair(otp: String) {
        try! core.pairRemoteWithOneTimePasscode(otp)
    }
    
    public func openForPairing() {
        try! core.enablePairingMode(120)
    }
    
    public func connectToPeer(peerId: String) throws -> MDGPeerConnection {
        if let connectionIndex = self.core.connections.indexOf({ $0.peerId == peerId }) {
            return self.core.connections[connectionIndex]
        }
        else {
            return try self.core.placeCallRemoteWithPeerId(peerId, protocolName: "chat-client", timeout: 10)
        }
    }
    
    public func setPeerName(name: String?, forPeerId peerId: String) {
        guard let name = name where name != "" else {
            return
        }
        peerNames[peerId] = name
        NSUserDefaults.standardUserDefaults().setObject(peerNames, forKey: PeerNamesKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    public func peerName(peerId: String) -> String {
        if let peerName = peerNames[peerId] where peerName != "" {
            return peerName
        }
        return peerId.substringToIndex(peerId.startIndex.advancedBy(12)) + "..."
    }
}

extension MDGClient: MDGCoreDelegate {
    public func pairingStateChanged(state: MDGPairingState) {
        if let delegate = pairingDelegate {
            delegate.pairingStateChanged(state)
        }
    }
    
    public func routingStatusChanged(connection: MDGPeerConnection, toStatus status: MDGRoutingStatus) {
        connection.delegate = self
        if let delegate = connectionDelegate {
            delegate.routingStatusChanged(connection, status: status)
        }
    }
}

extension MDGClient: MDGPeerConnectionDelegate {
    public func connection(connection: MDGPeerConnection, didReceiveData data: NSData) {
        self.messageStorage.addData(data, forConnection: connection, sender: .Them)
    }
}