//
//  DigitalCrownDemoView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct DigitalCrownDemoView: View {
    @State private var gestureService = GestureService.shared
    @State private var crownValue: Double = 0.0
    @State private var rotationAngle: Double = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
            
            // Visual Indicator
            ZStack {
                Circle()
                    .stroke(.blue.opacity(0.3), lineWidth: 4)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: abs(crownValue) / 10.0)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                Image(systemName: "digitalcrown.horizontal.arrow.counterclockwise")
                    .font(.system(size: 40))
                    .foregroundStyle(.blue)
                    .rotationEffect(.degrees(rotationAngle))
            }
            
            // Value Display
            VStack(spacing: 4) {
                Text("Crown Value")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(String(format: "%.2f", crownValue))
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .foregroundStyle(.blue)
            }
            
            Spacer()
            
            // Instructions
            Text("Rotate the Digital Crown")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            // Reset Button
            Button {
                crownValue = 0.0
                rotationAngle = 0.0
                gestureService.updateCrownValue(0.0)
            } label: {
                Label("Reset", systemImage: "arrow.counterclockwise")
                    .font(.caption)
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            }
            .padding()
        }
        .navigationTitle("Digital Crown")
        .navigationBarTitleDisplayMode(.inline)
        .focusable()
        .digitalCrownRotation($crownValue, from: -10.0, through: 10.0, by: 0.1, sensitivity: .low)
        .onChange(of: crownValue) { oldValue, newValue in
            rotationAngle = newValue * 36.0 // 360 degrees per 10 units
            gestureService.updateCrownValue(newValue)
            gestureService.recordGesture(.digitalCrown, value: newValue)
        }
    }
}

#Preview {
    NavigationStack {
        DigitalCrownDemoView()
    }
}
