//
//  HeartRateMonitorView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HeartRateMonitorView: View {
    @State private var healthService = HealthService.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                
                // Heart Rate Display
                ZStack {
                    // Pulsing background
                    Circle()
                        .fill(.red.opacity(0.2))
                        .frame(width: 120, height: 120)
                        .scaleEffect(healthService.isMonitoring ? 1.1 : 1.0)
                        .animation(
                            healthService.isMonitoring
                                ? .easeInOut(duration: 0.8).repeatForever(autoreverses: true)
                                : .default,
                            value: healthService.isMonitoring
                        )
                    
                    // Heart icon
                    VStack(spacing: 8) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.red)
                            .symbolEffect(.pulse, options: .repeating, isActive: healthService.isMonitoring)
                        
                        if healthService.isMonitoring {
                            Text("\(Int(healthService.currentHeartRate))")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundStyle(.red)
                            
                            Text("BPM")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("--")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundStyle(.secondary)
                            
                            Text("BPM")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Statistics
                if healthService.isMonitoring && !healthService.heartRateHistory.isEmpty {
                    VStack(spacing: 8) {
                        HStack {
                            StatItem(label: "Average", value: String(format: "%.0f", healthService.averageHeartRate))
                            Divider()
                            StatItem(label: "Max", value: String(format: "%.0f", healthService.maxHeartRate))
                        }
                        .frame(height: 40)
                        
                        HStack {
                            StatItem(label: "Min", value: String(format: "%.0f", healthService.minHeartRate))
                            Divider()
                            StatItem(label: "Readings", value: "\(healthService.heartRateHistory.count)")
                        }
                        .frame(height: 40)
                    }
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
                
                // Control Buttons
                VStack(spacing: 8) {
                    if !healthService.isMonitoring {
                        Button {
                            healthService.startHeartRateMonitoring()
                        } label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Start Monitoring")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(.red)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                        .disabled(!healthService.isAuthorized)
                    } else {
                        Button {
                            healthService.stopHeartRateMonitoring()
                        } label: {
                            HStack {
                                Image(systemName: "stop.fill")
                                Text("Stop Monitoring")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                    
                    if !healthService.isAuthorized {
                        Text("Authorization required")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Heart Rate")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            healthService.stopHeartRateMonitoring()
        }
    }
}

// MARK: - Stat Item Component

struct StatItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(.body, design: .rounded))
                .fontWeight(.semibold)
            
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        HeartRateMonitorView()
    }
}
