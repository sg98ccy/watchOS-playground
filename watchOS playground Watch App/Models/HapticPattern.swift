//
//  HapticPattern.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import Foundation
import WatchKit

/// Represents different haptic feedback patterns available on watchOS
enum HapticPattern: String, CaseIterable, Identifiable {
    case notification = "Notification"
    case directionUp = "Direction Up"
    case directionDown = "Direction Down"
    case success = "Success"
    case failure = "Failure"
    case retry = "Retry"
    case start = "Start"
    case stop = "Stop"
    case click = "Click"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .notification:
            return "bell.fill"
        case .directionUp:
            return "arrow.up.circle.fill"
        case .directionDown:
            return "arrow.down.circle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .failure:
            return "xmark.circle.fill"
        case .retry:
            return "arrow.clockwise.circle.fill"
        case .start:
            return "play.circle.fill"
        case .stop:
            return "stop.circle.fill"
        case .click:
            return "hand.tap.fill"
        }
    }
    
    var description: String {
        switch self {
        case .notification:
            return "Standard notification"
        case .directionUp:
            return "Upward direction"
        case .directionDown:
            return "Downward direction"
        case .success:
            return "Success feedback"
        case .failure:
            return "Failure feedback"
        case .retry:
            return "Retry prompt"
        case .start:
            return "Action start"
        case .stop:
            return "Action stop"
        case .click:
            return "Simple click"
        }
    }
    
    var hapticType: WKHapticType {
        switch self {
        case .notification:
            return .notification
        case .directionUp:
            return .directionUp
        case .directionDown:
            return .directionDown
        case .success:
            return .success
        case .failure:
            return .failure
        case .retry:
            return .retry
        case .start:
            return .start
        case .stop:
            return .stop
        case .click:
            return .click
        }
    }
    
    var color: String {
        switch self {
        case .notification:
            return "blue"
        case .directionUp:
            return "green"
        case .directionDown:
            return "orange"
        case .success:
            return "green"
        case .failure:
            return "red"
        case .retry:
            return "yellow"
        case .start:
            return "green"
        case .stop:
            return "red"
        case .click:
            return "gray"
        }
    }
}
