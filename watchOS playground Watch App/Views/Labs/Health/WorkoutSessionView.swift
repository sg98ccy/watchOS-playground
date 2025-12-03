//
//  WorkoutSessionView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct WorkoutSessionView: View {
    @State private var healthService = HealthService.shared
    @State private var showingWorkoutPicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if !healthService.isWorkoutActive {
                    // Workout Type Selection
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Image(systemName: "figure.run")
                            .font(.system(size: 60))
                            .foregroundStyle(.orange)
                        
                        Text("Start a Workout")
                            .font(.headline)
                        
                        Text("Choose a workout type")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    // Workout Type Grid
                    VStack(spacing: 8) {
                        ForEach(WorkoutType.allCases) { type in
                            Button {
                                healthService.startWorkout(type: type)
                            } label: {
                                HStack {
                                    Image(systemName: type.icon)
                                        .font(.title3)
                                    
                                    Text(type.rawValue)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "play.circle.fill")
                                        .foregroundStyle(colorForType(type))
                                }
                                .padding()
                                .background(colorForType(type).opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .buttonStyle(.plain)
                            .disabled(!healthService.isAuthorized)
                        }
                    }
                    
                    if !healthService.isAuthorized {
                        Text("Authorization required")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                    }
                    
                    Spacer()
                } else {
                    // Active Workout Display
                    VStack(spacing: 20) {
                        // Workout Type Header
                        if let workoutType = healthService.workoutType {
                            VStack(spacing: 8) {
                                Image(systemName: workoutType.icon)
                                    .font(.system(size: 40))
                                    .foregroundStyle(colorForType(workoutType))
                                
                                Text(workoutType.rawValue)
                                    .font(.headline)
                            }
                            .padding(.top, 20)
                        }
                        
                        // Time Display
                        VStack(spacing: 4) {
                            Text(healthService.formattedWorkoutDuration)
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundStyle(.orange)
                            
                            Text("Duration")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        // Stats Grid
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                MetricCard(
                                    icon: "heart.fill",
                                    value: String(format: "%.0f", healthService.currentHeartRate),
                                    label: "BPM",
                                    color: .red
                                )
                                
                                MetricCard(
                                    icon: "flame.fill",
                                    value: String(format: "%.0f", healthService.workoutCalories),
                                    label: "CAL",
                                    color: .orange
                                )
                            }
                        }
                        
                        Spacer()
                        
                        // Control Buttons
                        Button {
                            healthService.stopWorkout()
                        } label: {
                            HStack {
                                Image(systemName: "stop.fill")
                                Text("End Workout")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(.red)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Workout")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            if healthService.isWorkoutActive {
                healthService.stopWorkout()
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func colorForType(_ type: WorkoutType) -> Color {
        switch type.color {
        case "green": return .green
        case "red": return .red
        case "blue": return .blue
        case "orange": return .orange
        case "purple": return .purple
        case "cyan": return .cyan
        default: return .primary
        }
    }
}

// MARK: - Metric Card Component

struct MetricCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            
            Text(value)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationStack {
        WorkoutSessionView()
    }
}
