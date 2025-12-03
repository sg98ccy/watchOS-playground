//
//  HapticsService.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import Foundation
import WatchKit

/// Service for managing haptic feedback on watchOS
@Observable
class HapticsService {
    
    // MARK: - Singleton
    
    static let shared = HapticsService()
    
    // MARK: - Properties
    
    /// Last played haptic pattern
    var lastPattern: HapticPattern?
    
    /// Count of haptics played in current session
    var hapticCount: Int = 0
    
    /// Whether haptics are enabled
    var isEnabled: Bool = true
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Public Methods
    
    /// Play a specific haptic pattern
    /// - Parameter pattern: The haptic pattern to play
    func play(_ pattern: HapticPattern) {
        guard isEnabled else { return }
        
        WKInterfaceDevice.current().play(pattern.hapticType)
        lastPattern = pattern
        hapticCount += 1
    }
    
    /// Play notification haptic
    func playNotification() {
        play(.notification)
    }
    
    /// Play success haptic
    func playSuccess() {
        play(.success)
    }
    
    /// Play failure haptic
    func playFailure() {
        play(.failure)
    }
    
    /// Play click haptic
    func playClick() {
        play(.click)
    }
    
    /// Play a sequence of haptic patterns
    /// - Parameters:
    ///   - patterns: Array of patterns to play
    ///   - delay: Delay between each pattern in seconds
    func playSequence(_ patterns: [HapticPattern], delay: TimeInterval = 0.3) {
        guard isEnabled else { return }
        
        for (index, pattern) in patterns.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (delay * Double(index))) {
                self.play(pattern)
            }
        }
    }
    
    /// Play a rhythm pattern
    /// - Parameter count: Number of clicks to play
    func playRhythm(count: Int = 3) {
        guard isEnabled else { return }
        
        for i in 0..<count {
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * Double(i))) {
                self.play(.click)
            }
        }
    }
    
    /// Toggle haptics enabled state
    func toggleEnabled() {
        isEnabled.toggle()
    }
    
    /// Reset haptic count
    func resetCount() {
        hapticCount = 0
        lastPattern = nil
    }
}

// MARK: - Convenience Methods

extension HapticsService {
    /// Play haptic for button press
    func buttonPress() {
        play(.click)
    }
    
    /// Play haptic for navigation
    func navigation() {
        play(.directionUp)
    }
    
    /// Play haptic for selection
    func selection() {
        play(.click)
    }
    
    /// Play haptic for error
    func error() {
        play(.failure)
    }
    
    /// Play haptic for completion
    func completion() {
        play(.success)
    }
}
