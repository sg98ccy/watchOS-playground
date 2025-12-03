//
//  GestureService.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import Foundation
import SwiftUI

/// Service for tracking and managing gesture events
@Observable
class GestureService {
    
    // MARK: - Singleton
    
    static let shared = GestureService()
    
    // MARK: - Properties
    
    /// Recent gesture events (limited to last 10)
    var recentEvents: [GestureEvent] = []
    
    /// Digital Crown rotation value
    var crownValue: Double = 0.0
    
    /// Tap count for tracking consecutive taps
    var tapCount: Int = 0
    
    /// Drag offset tracking
    var dragOffset: CGSize = .zero
    
    // MARK: - Constants
    
    private let maxEvents = 10
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Public Methods
    
    /// Record a gesture event
    func recordGesture(_ type: GestureType, value: Double? = nil) {
        let event = GestureEvent(type: type, value: value)
        recentEvents.insert(event, at: 0)
        
        // Keep only recent events
        if recentEvents.count > maxEvents {
            recentEvents.removeLast()
        }
    }
    
    /// Update Digital Crown value
    func updateCrownValue(_ value: Double) {
        crownValue = value
    }
    
    /// Increment tap count
    func incrementTapCount() {
        tapCount += 1
        recordGesture(.tap)
    }
    
    /// Reset tap count
    func resetTapCount() {
        tapCount = 0
    }
    
    /// Update drag offset
    func updateDragOffset(_ offset: CGSize) {
        dragOffset = offset
    }
    
    /// Reset drag offset
    func resetDragOffset() {
        dragOffset = .zero
    }
    
    /// Clear all gesture history
    func clearHistory() {
        recentEvents.removeAll()
        tapCount = 0
        crownValue = 0.0
        dragOffset = .zero
    }
}
