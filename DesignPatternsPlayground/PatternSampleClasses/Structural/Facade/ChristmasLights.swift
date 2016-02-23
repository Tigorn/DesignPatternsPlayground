//
//  ChristmasLights.swift
//  DesignPatternsPlayground
//
//  Created by Ricardo Pramana Suranta on 2/15/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import Foundation

class ChristmasLights {
    
    private var battery: DCRechargeableBattery
    private var timer: NSTimer?
    
    /// Emojis that used to present this instance.
    internal var lightEmojis = ""
    
    internal let minimumVoltage = 3
    internal let preferredVoltage = 5
    internal let maximumVoltage = 6
    
    internal let minimumDCCurrent = 5
    
    private let refreshEmojiInterval = NSTimeInterval(0.5)
    
    private let lightEmojisDefaultLength = 12
    
    static private let validEmojis = [
        "❤️", "💜", "💛",
        "💚", "💙", "🔴",
        "🔵", "🔶", "🔷",
        "⭐️", "✨", "⚪️"
    ]
    
    init(battery: DCRechargeableBattery) {
        self.battery = battery
        turnOn()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    /**
    Periodically change this instance's `lightEmojis` as long as its `battery` has enough `DCCurrent` and matching voltage.
    */
    internal func turnOn() {
        timer = NSTimer.scheduledTimerWithTimeInterval(refreshEmojiInterval,
            target: self,
            selector: Selector("refreshLightEmoji"),
            userInfo: nil,
            repeats: true
        )
    }
    
    /**
    Resets this instance's `lightEmojis` and stops it from request `DCCurrent`s from its battery.
    */
    internal func turnOff() {
        timer?.invalidate()
        timer = nil
        
        lightEmojis = ""
    }
    
    @objc private func refreshLightEmoji() {
    
        lightEmojis = ""
        
        let validVoltage = battery.voltage <= maximumVoltage && battery.voltage >= minimumVoltage
        
        if !validVoltage {
            return
        }
        
        let availableCurrents = battery.retrieveCurrents(minimumDCCurrent)
        
        if availableCurrents.count <= minimumDCCurrent {
            return
        }
        
        lightEmojis = retrieveRandomEmojis()
    }
    
    private func retrieveRandomEmojis() -> String {
        
        let voltageRatio = Double(battery.voltage / preferredVoltage)
        let emojisLength = lightEmojisDefaultLength * Int(ceil(voltageRatio))
        
        var emojis = ""
        
        for _ in 0 ..< emojisLength {
            
            if let randomisedEmoji = ChristmasLights.validEmojis.randomElement() {
                emojis.appendContentsOf(randomisedEmoji)
            }
        }
        
        return emojis
    }
    
}