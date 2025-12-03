//
//  GestureType.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import Foundation

/// Represents different types of gestures supported in the lab
enum GestureType: String, CaseIterable, Identifiable {
    case tap = "Tap"
    case longPress = "Long Press"
    case drag = "Drag"
    case doubleTap = "Double Tap"
    case digitalCrown = "Digital Crown"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .tap:
            return "hand.tap"
        case .longPress:
            return "hand.tap.fill"
        case .drag:
            return "hand.draw"
        case .doubleTap:
            return "hand.tap"
        case .digitalCrown:
            return "digitalcrown.horizontal.arrow.counterclockwise"
        }
    }
    
    var description: String {
        switch self {
        case .tap:
            return "Simple tap gesture"
        case .longPress:
            return "Tap and hold"
        case .drag:
            return "Swipe and drag"
        case .doubleTap:
            return "Quick double tap"
        case .digitalCrown:
            return "Crown rotation"
        }
    }
}

/// Model representing a gesture event
struct GestureEvent: Identifiable {
    let id = UUID()
    let type: GestureType
    let timestamp: Date
    let value: Double?
    
    init(type: GestureType, value: Double? = nil) {
        self.type = type
        self.timestamp = Date()
        self.value = value
    }
    
    var displayValue: String {
        if let value = value {
            return String(format: "%.2f", value)
        }
        return "—"
    }
}
