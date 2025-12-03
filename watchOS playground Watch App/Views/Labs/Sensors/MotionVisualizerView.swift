//
//  MotionVisualizerView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 2/12/25.
//

import SwiftUI

struct MotionVisualizerView: View {
    @State private var motionService = MotionService.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                RadialGradient(
                    colors: [.blue.opacity(0.1), .clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: geometry.size.width / 2
                )
                
                // Grid lines for reference
                GridOverlay()
                
                // Center crosshair
                Crosshair()
                
                // Motion dot
                MotionDot(
                    x: motionService.currentSample.x,
                    y: motionService.currentSample.y,
                    geometry: geometry
                )
                
                // Data overlay
                VStack {
                    Spacer()
                    
                    DataOverlay(sample: motionService.currentSample)
                        .padding(.bottom, 8)
                }
            }
        }
        .navigationTitle("Motion Visualizer")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            motionService.startTracking()
        }
        .onDisappear {
            motionService.stopTracking()
        }
    }
}

// MARK: - Grid Overlay

struct GridOverlay: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack {
                // Vertical center line
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 1, height: height)
                
                // Horizontal center line
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(width: width, height: 1)
                
                // Quarter circles
                Circle()
                    .stroke(.white.opacity(0.05), lineWidth: 1)
                    .frame(width: width * 0.5, height: width * 0.5)
                
                Circle()
                    .stroke(.white.opacity(0.05), lineWidth: 1)
                    .frame(width: width * 0.75, height: width * 0.75)
            }
        }
    }
}

// MARK: - Crosshair

struct Crosshair: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.3), lineWidth: 2)
                .frame(width: 12, height: 12)
            
            Circle()
                .fill(.white.opacity(0.5))
                .frame(width: 4, height: 4)
        }
    }
}

// MARK: - Motion Dot

struct MotionDot: View {
    let x: Double
    let y: Double
    let geometry: GeometryProxy
    
    var body: some View {
        let size = geometry.size
        let dotSize: CGFloat = 24
        
        // Calculate position based on accelerometer data
        // X: -1 (left) to +1 (right)
        // Y: -1 (bottom) to +1 (top), but we need to invert for screen coordinates
        let maxOffset = min(size.width, size.height) / 2 - dotSize
        let xOffset = CGFloat(x) * maxOffset
        let yOffset = CGFloat(-y) * maxOffset // Invert Y for natural feel
        
        ZStack {
            // Glow effect
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.blue.opacity(0.6), .blue.opacity(0)],
                        center: .center,
                        startRadius: 0,
                        endRadius: dotSize
                    )
                )
                .frame(width: dotSize * 2, height: dotSize * 2)
            
            // Main dot
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.blue, .cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: dotSize, height: dotSize)
                .shadow(color: .blue.opacity(0.5), radius: 8)
            
            // Inner highlight
            Circle()
                .fill(.white.opacity(0.3))
                .frame(width: dotSize * 0.4, height: dotSize * 0.4)
                .offset(x: -dotSize * 0.1, y: -dotSize * 0.1)
        }
        .offset(x: xOffset, y: yOffset)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: x)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: y)
    }
}

// MARK: - Data Overlay

struct DataOverlay: View {
    let sample: SensorSample
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 12) {
                DataLabel(label: "X", value: sample.x, color: .red)
                DataLabel(label: "Y", value: sample.y, color: .green)
                DataLabel(label: "Z", value: sample.z, color: .blue)
            }
            
            Text("Move your wrist to see motion")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Data Label

struct DataLabel: View {
    let label: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.caption2)
                .foregroundStyle(color)
            
            Text(String(format: "%.2f", value))
                .font(.system(.caption, design: .monospaced))
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavigationStack {
        MotionVisualizerView()
    }
}
