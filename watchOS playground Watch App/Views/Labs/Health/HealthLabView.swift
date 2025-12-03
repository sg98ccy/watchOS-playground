//
//  HealthLabView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HealthLabView: View {
    @State private var healthService = HealthService.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                    
                    Text("Health Lab")
                        .font(.headline)
                }
                .padding(.top, 8)
                
                // Authorization Status
                if !healthService.isAuthorized {
                    VStack(spacing: 12) {
                        Image(systemName: "lock.shield")
                            .font(.title)
                            .foregroundStyle(.orange)
                        
                        Text("HealthKit Authorization Required")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            Task {
                                await healthService.requestAuthorization()
                            }
                        } label: {
                            Label("Authorize Access", systemImage: "checkmark.shield")
                                .font(.caption)
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                    }
                    .padding()
                    .background(.orange.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Heart Rate Monitor Link
                NavigationLink(destination: HeartRateMonitorView()) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Heart Rate Monitor")
                                .font(.headline)
                            Text("Live heart rate tracking")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.red.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                
                // Workout Session Link
                NavigationLink(destination: WorkoutSessionView()) {
                    HStack {
                        Image(systemName: "figure.run")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Workout Session")
                                .font(.headline)
                            Text("Track your activity")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.orange.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                
                // Health Stats Link
                NavigationLink(destination: HealthStatsView()) {
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Health Stats")
                                .font(.headline)
                            Text("View metrics history")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.green.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                
                // Error Message
                if let errorMessage = healthService.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(.red.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
        }
        .navigationTitle("Health")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HealthLabView()
    }
}
