//
//  MotionService.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 2/12/25.
//

import Foundation
import CoreMotion
import Combine

/// Service responsible for managing CoreMotion sensors and publishing motion data
@Observable
class MotionService {
    
    // MARK: - Singleton
    
    static let shared = MotionService()
    
    // MARK: - Published Properties
    
    /// Current accelerometer sample
    var currentSample: SensorSample = .placeholder
    
    /// Whether motion updates are currently active
    var isTracking: Bool = false
    
    /// Error message if motion tracking fails
    var errorMessage: String?
    
    // MARK: - Private Properties
    
    private let motionManager = CMMotionManager()
    private var updateTimer: Timer?
    
    /// Update interval for motion data (in Hz)
    private let updateInterval: TimeInterval = 1.0 / 60.0 // 60 Hz
    
    // MARK: - Initialization
    
    private init() {
        setupMotionManager()
    }
    
    // MARK: - Setup
    
    private func setupMotionManager() {
        motionManager.accelerometerUpdateInterval = updateInterval
        motionManager.gyroUpdateInterval = updateInterval
    }
    
    // MARK: - Public Methods
    
    /// Start tracking accelerometer motion
    func startTracking() {
        guard !isTracking else { return }
        
        // Check if accelerometer is available
        guard motionManager.isAccelerometerAvailable else {
            errorMessage = "Accelerometer not available on this device"
            return
        }
        
        errorMessage = nil
        isTracking = true
        
        // Start accelerometer updates
        motionManager.startAccelerometerUpdates()
        
        // Create timer for reading data
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in
            self?.updateMotionData()
        }
    }
    
    /// Stop tracking motion
    func stopTracking() {
        guard isTracking else { return }
        
        isTracking = false
        motionManager.stopAccelerometerUpdates()
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    // MARK: - Private Methods
    
    private func updateMotionData() {
        guard let accelerometerData = motionManager.accelerometerData else {
            return
        }
        
        let acceleration = accelerometerData.acceleration
        
        currentSample = SensorSample(
            timestamp: Date(),
            x: acceleration.x,
            y: acceleration.y,
            z: acceleration.z
        )
    }
    
    // MARK: - Cleanup
    
    deinit {
        stopTracking()
    }
}

// MARK: - Computed Properties

extension MotionService {
    /// Whether the device supports motion tracking
    var isMotionAvailable: Bool {
        motionManager.isAccelerometerAvailable
    }
    
    /// Normalized x position for UI (0...1 range)
    var normalizedX: Double {
        (currentSample.x + 1.0) / 2.0
    }
    
    /// Normalized y position for UI (0...1 range)
    var normalizedY: Double {
        (currentSample.y + 1.0) / 2.0
    }
}
