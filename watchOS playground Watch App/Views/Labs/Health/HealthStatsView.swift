//
//  HealthStatsView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HealthStatsView: View {
    @State private var healthService = HealthService.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Heart Rate History
                if !healthService.heartRateHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                            Text("Heart Rate History")
                                .font(.headline)
                        }
                        
                        Divider()
                        
                        ForEach(healthService.heartRateHistory.prefix(10)) { metric in
                            HStack {
                                Image(systemName: metric.type.icon)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 20)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(metric.displayValue) \(metric.unit)")
                                        .font(.system(.body, design: .rounded))
                                        .fontWeight(.semibold)
                                    
                                    Text(metric.timestamp, style: .time)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                // Visual indicator
                                Circle()
                                    .fill(heartRateColor(for: metric.value))
                                    .frame(width: 8, height: 8)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    // Empty State
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 60))
                            .foregroundStyle(.secondary)
                        
                        Text("No Health Data")
                            .font(.headline)
                        
                        Text("Start monitoring heart rate to see your stats here")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        NavigationLink(destination: HeartRateMonitorView()) {
                            Label("Start Monitoring", systemImage: "play.fill")
                                .font(.caption)
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                        
                        Spacer()
                    }
                    .padding()
                }
                
                // Summary Stats
                if !healthService.heartRateHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "chart.bar.fill")
                                .foregroundStyle(.green)
                            Text("Summary")
                                .font(.headline)
                        }
                        
                        Divider()
                        
                        StatRow(label: "Average HR", value: String(format: "%.0f BPM", healthService.averageHeartRate))
                        StatRow(label: "Maximum HR", value: String(format: "%.0f BPM", healthService.maxHeartRate))
                        StatRow(label: "Minimum HR", value: String(format: "%.0f BPM", healthService.minHeartRate))
                        StatRow(label: "Total Readings", value: "\(healthService.heartRateHistory.count)")
                    }
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("Health Stats")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Methods
    
    private func heartRateColor(for bpm: Double) -> Color {
        switch bpm {
        case 0..<60:
            return .blue
        case 60..<100:
            return .green
        case 100..<140:
            return .orange
        default:
            return .red
        }
    }
}

#Preview {
    NavigationStack {
        HealthStatsView()
    }
}
