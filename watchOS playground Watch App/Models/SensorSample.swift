//
//  SensorSample.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 2/12/25.
//

import Foundation

/// Model representing a single motion sensor reading
struct SensorSample {
    /// Timestamp when the sample was captured
    let timestamp: Date
    
    /// Acceleration along the x-axis (lateral movement)
    let x: Double
    
    /// Acceleration along the y-axis (vertical movement)
    let y: Double
    
    /// Acceleration along the z-axis (forward/backward movement)
    let z: Double
    
    /// Computed magnitude of the acceleration vector
    var magnitude: Double {
        sqrt(x * x + y * y + z * z)
    }
    
    /// Initialize with raw acceleration values
    init(timestamp: Date = Date(), x: Double, y: Double, z: Double) {
        self.timestamp = timestamp
        self.x = x
        self.y = y
        self.z = z
    }
    
    /// Normalize a value to a range suitable for UI positioning
    /// - Parameters:
    ///   - value: The raw sensor value to normalize
    ///   - range: The input range (typically -1.0 to 1.0 for acceleration)
    ///   - bounds: The output bounds for UI (e.g., screen width/height)
    /// - Returns: Normalized value within the specified bounds
    static func normalize(_ value: Double, from range: ClosedRange<Double> = -1.0...1.0, to bounds: ClosedRange<Double>) -> Double {
        let normalized = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return bounds.lowerBound + normalized * (bounds.upperBound - bounds.lowerBound)
    }
}

extension SensorSample {
    /// Static placeholder for preview and testing purposes
    static let placeholder = SensorSample(x: 0.0, y: 0.0, z: 0.0)
    
    /// Sample data for preview with some movement
    static let preview = SensorSample(x: 0.3, y: -0.2, z: 0.98)
}
