//
//  HealthService.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import Foundation
import HealthKit

/// Service for managing HealthKit data and workout sessions
@Observable
class HealthService {
    
    // MARK: - Singleton
    
    static let shared = HealthService()
    
    // MARK: - Properties
    
    /// Current heart rate in BPM
    var currentHeartRate: Double = 0.0
    
    /// Whether heart rate monitoring is active
    var isMonitoring: Bool = false
    
    /// Recent heart rate measurements
    var heartRateHistory: [HealthMetric] = []
    
    /// HealthKit authorization status
    var isAuthorized: Bool = false
    
    /// Error message if any
    var errorMessage: String?
    
    /// Simulated workout state
    var isWorkoutActive: Bool = false
    var workoutType: WorkoutType?
    var workoutDuration: TimeInterval = 0.0
    var workoutCalories: Double = 0.0
    
    // MARK: - Private Properties
    
    private let healthStore = HKHealthStore()
    private var heartRateQuery: HKQuery?
    private var workoutTimer: Timer?
    
    // MARK: - Initialization
    
    private init() {
        checkHealthKitAvailability()
    }
    
    // MARK: - Authorization
    
    private func checkHealthKitAvailability() {
        guard HKHealthStore.isHealthDataAvailable() else {
            errorMessage = "HealthKit not available on this device"
            return
        }
    }
    
    /// Request authorization for HealthKit data
    func requestAuthorization() async {
        guard HKHealthStore.isHealthDataAvailable() else {
            errorMessage = "HealthKit not available"
            return
        }
        
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        do {
            try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
            isAuthorized = true
            errorMessage = nil
        } catch {
            errorMessage = "Authorization failed: \(error.localizedDescription)"
            isAuthorized = false
        }
    }
    
    // MARK: - Heart Rate Monitoring
    
    /// Start monitoring heart rate
    func startHeartRateMonitoring() {
        guard isAuthorized else {
            errorMessage = "Please authorize HealthKit access first"
            return
        }
        
        // For demo purposes, simulate heart rate data
        // In production, you'd use HKAnchoredObjectQuery for real-time updates
        isMonitoring = true
        startSimulatedHeartRate()
    }
    
    /// Stop monitoring heart rate
    func stopHeartRateMonitoring() {
        isMonitoring = false
        if let query = heartRateQuery {
            healthStore.stop(query)
        }
    }
    
    // MARK: - Workout Management
    
    /// Start a workout session
    func startWorkout(type: WorkoutType) {
        guard !isWorkoutActive else { return }
        
        isWorkoutActive = true
        workoutType = type
        workoutDuration = 0.0
        workoutCalories = 0.0
        
        // Start workout timer
        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateWorkoutStats()
        }
        
        startHeartRateMonitoring()
    }
    
    /// Stop the current workout
    func stopWorkout() {
        guard isWorkoutActive else { return }
        
        isWorkoutActive = false
        workoutTimer?.invalidate()
        workoutTimer = nil
        workoutType = nil
        
        stopHeartRateMonitoring()
    }
    
    /// Pause the current workout
    func pauseWorkout() {
        workoutTimer?.invalidate()
        workoutTimer = nil
    }
    
    /// Resume the current workout
    func resumeWorkout() {
        guard isWorkoutActive else { return }
        
        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateWorkoutStats()
        }
    }
    
    // MARK: - Private Methods
    
    private func startSimulatedHeartRate() {
        // Simulate heart rate updates every 2 seconds
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
            guard let self = self, self.isMonitoring else {
                timer.invalidate()
                return
            }
            
            // Simulate heart rate between 60-180 BPM
            let baseRate = self.isWorkoutActive ? 120.0 : 70.0
            let variation = Double.random(in: -15...15)
            self.currentHeartRate = baseRate + variation
            
            let metric = HealthMetric(
                value: self.currentHeartRate,
                unit: "BPM",
                type: .heartRate
            )
            
            self.heartRateHistory.insert(metric, at: 0)
            
            // Keep only last 20 readings
            if self.heartRateHistory.count > 20 {
                self.heartRateHistory.removeLast()
            }
        }
    }
    
    private func updateWorkoutStats() {
        workoutDuration += 1.0
        
        // Simulate calorie burn based on workout type and heart rate
        let caloriesPerSecond: Double
        switch workoutType {
        case .running, .hiit:
            caloriesPerSecond = 0.15
        case .cycling, .walking:
            caloriesPerSecond = 0.10
        case .strength:
            caloriesPerSecond = 0.08
        case .yoga:
            caloriesPerSecond = 0.05
        case .none:
            caloriesPerSecond = 0.05
        }
        
        workoutCalories += caloriesPerSecond
    }
    
    // MARK: - Cleanup
    
    deinit {
        stopHeartRateMonitoring()
        stopWorkout()
    }
}

// MARK: - Computed Properties

extension HealthService {
    var formattedWorkoutDuration: String {
        let minutes = Int(workoutDuration) / 60
        let seconds = Int(workoutDuration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var averageHeartRate: Double {
        guard !heartRateHistory.isEmpty else { return 0.0 }
        let sum = heartRateHistory.reduce(0.0) { $0 + $1.value }
        return sum / Double(heartRateHistory.count)
    }
    
    var maxHeartRate: Double {
        heartRateHistory.map(\.value).max() ?? 0.0
    }
    
    var minHeartRate: Double {
        heartRateHistory.map(\.value).min() ?? 0.0
    }
}
