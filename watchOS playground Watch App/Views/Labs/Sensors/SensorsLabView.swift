//
//  SensorsLabView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 2/12/25.
//

import SwiftUI

struct SensorsLabView: View {
    @State private var motionService = MotionService.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(spacing: 4) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                    
                    Text("Sensors Lab")
                        .font(.headline)
                }
                .padding(.top, 8)
                
                // Motion Visualizer Link
                NavigationLink(destination: MotionVisualizerView()) {
                    HStack {
                        Image(systemName: "dot.scope")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Motion Visualizer")
                                .font(.headline)
                            Text("Live tilt demo")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.blue.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                
                // Accelerometer Data Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "gyroscope")
                            .foregroundStyle(.green)
                        Text("Accelerometer")
                            .font(.headline)
                    }
                    
                    Divider()
                    
                    // X Axis
                    SensorRow(
                        label: "X",
                        value: motionService.currentSample.x,
                        color: .red
                    )
                    
                    // Y Axis
                    SensorRow(
                        label: "Y",
                        value: motionService.currentSample.y,
                        color: .green
                    )
                    
                    // Z Axis
                    SensorRow(
                        label: "Z",
                        value: motionService.currentSample.z,
                        color: .blue
                    )
                    
                    Divider()
                    
                    // Magnitude
                    HStack {
                        Text("Magnitude")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.3f", motionService.currentSample.magnitude))
                            .font(.system(.body, design: .monospaced))
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Status Indicator
                HStack {
                    Circle()
                        .fill(motionService.isTracking ? .green : .gray)
                        .frame(width: 8, height: 8)
                    
                    Text(motionService.isTracking ? "Tracking Active" : "Tracking Inactive")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                // Error Message
                if let errorMessage = motionService.errorMessage {
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
        .navigationTitle("Sensors")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            motionService.startTracking()
        }
        .onDisappear {
            motionService.stopTracking()
        }
    }
}

// MARK: - Sensor Row Component

struct SensorRow: View {
    let label: String
    let value: Double
    let color: Color
    
    var body: some View {
        HStack {
            // Label
            Text(label)
                .font(.caption)
                .foregroundStyle(color)
                .frame(width: 20, alignment: .leading)
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    Rectangle()
                        .fill(.secondary.opacity(0.2))
                    
                    // Value indicator (centered at 0)
                    let width = geometry.size.width
                    let center = width / 2
                    let offset = CGFloat(value) * (width / 2)
                    let barWidth = abs(offset)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: barWidth)
                        .offset(x: value >= 0 ? center : center + offset)
                    
                    // Center line
                    Rectangle()
                        .fill(.white.opacity(0.5))
                        .frame(width: 1)
                        .offset(x: center)
                }
            }
            .frame(height: 6)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            
            // Numeric value
            Text(String(format: "%+.2f", value))
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(.secondary)
                .frame(width: 50, alignment: .trailing)
        }
    }
}

#Preview {
    NavigationStack {
        SensorsLabView()
    }
}
