//
//  TapGesturesDemoView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct TapGesturesDemoView: View {
    @State private var gestureService = GestureService.shared
    @State private var tapCount: Int = 0
    @State private var lastTapType: String = "None"
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
            
            // Interactive Target
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [.green.opacity(0.6), .green.opacity(0.2)],
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        )
                    )
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                
                VStack(spacing: 4) {
                    Image(systemName: "hand.tap")
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Text("TAP")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .onTapGesture {
                handleSingleTap()
            }
            .onTapGesture(count: 2) {
                handleDoubleTap()
            }
            
            // Stats Display
            VStack(spacing: 12) {
                StatRow(label: "Total Taps", value: "\(tapCount)")
                StatRow(label: "Last Gesture", value: lastTapType)
            }
            .padding()
            .background(.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            // Instructions
            VStack(spacing: 4) {
                Text("Single tap or double tap")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("the green circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // Reset Button
            Button {
                tapCount = 0
                lastTapType = "None"
                gestureService.resetTapCount()
            } label: {
                Label("Reset", systemImage: "arrow.counterclockwise")
                    .font(.caption)
            }
            .buttonStyle(.bordered)
            .tint(.green)
            }
            .padding()
        }
        .navigationTitle("Tap Gestures")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Methods
    
    private func handleSingleTap() {
        tapCount += 1
        lastTapType = "Single Tap"
        gestureService.recordGesture(.tap)
        
        // Visual feedback
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            scale = 1.2
        }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5).delay(0.1)) {
            scale = 1.0
        }
    }
    
    private func handleDoubleTap() {
        tapCount += 2
        lastTapType = "Double Tap"
        gestureService.recordGesture(.doubleTap)
        
        // Visual feedback
        withAnimation(.spring(response: 0.2, dampingFraction: 0.4)) {
            scale = 1.4
        }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5).delay(0.15)) {
            scale = 1.0
        }
    }
}

// MARK: - Stat Row Component

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.system(.body, design: .monospaced))
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavigationStack {
        TapGesturesDemoView()
    }
}
