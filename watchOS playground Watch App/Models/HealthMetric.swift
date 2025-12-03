//
//  HealthMetric.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import Foundation

/// Represents a health data point
struct HealthMetric: Identifiable {
    let id = UUID()
    let timestamp: Date
    let value: Double
    let unit: String
    let type: MetricType
    
    enum MetricType: String {
        case heartRate = "Heart Rate"
        case activeEnergy = "Active Energy"
        case steps = "Steps"
        case distance = "Distance"
        
        var icon: String {
            switch self {
            case .heartRate:
                return "heart.fill"
            case .activeEnergy:
                return "flame.fill"
            case .steps:
                return "figure.walk"
            case .distance:
                return "arrow.left.and.right"
            }
        }
    }
    
    init(value: Double, unit: String, type: MetricType, timestamp: Date = Date()) {
        self.timestamp = timestamp
        self.value = value
        self.unit = unit
        self.type = type
    }
    
    var displayValue: String {
        String(format: "%.0f", value)
    }
    
    var displayString: String {
        "\(displayValue) \(unit)"
    }
}

/// Workout type enumeration
enum WorkoutType: String, CaseIterable, Identifiable {
    case walking = "Walking"
    case running = "Running"
    case cycling = "Cycling"
    case hiit = "HIIT"
    case yoga = "Yoga"
    case strength = "Strength"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .walking:
            return "figure.walk"
        case .running:
            return "figure.run"
        case .cycling:
            return "bicycle"
        case .hiit:
            return "flame.fill"
        case .yoga:
            return "figure.mind.and.body"
        case .strength:
            return "dumbbell.fill"
        }
    }
    
    var color: String {
        switch self {
        case .walking:
            return "green"
        case .running:
            return "red"
        case .cycling:
            return "blue"
        case .hiit:
            return "orange"
        case .yoga:
            return "purple"
        case .strength:
            return "cyan"
        }
    }
}
