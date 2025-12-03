//
//  LongPressDemoView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct LongPressDemoView: View {
    @State private var gestureService = GestureService.shared
    @State private var isPressed: Bool = false
    @State private var pressCount: Int = 0
    @State private var pressDuration: Double = 0.0
    @State private var pressProgress: Double = 0.0
    @State private var timer: Timer?
    
    private let longPressDuration: Double = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
            
            // Interactive Target
            ZStack {
                // Background ring
                Circle()
                    .stroke(.red.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: pressProgress)
                    .stroke(
                        LinearGradient(
                            colors: [.red, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                // Center content
                VStack(spacing: 8) {
                    Image(systemName: isPressed ? "hand.tap.fill" : "hand.tap")
                        .font(.system(size: 40))
                        .foregroundStyle(isPressed ? .red : .secondary)
                    
                    Text(isPressed ? "HOLDING" : "PRESS")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(isPressed ? .red : .secondary)
                }
                .scaleEffect(isPressed ? 1.1 : 1.0)
            }
            .gesture(
                LongPressGesture(minimumDuration: longPressDuration)
                    .onChanged { _ in
                        if !isPressed {
                            handlePressStart()
                        }
                    }
                    .onEnded { _ in
                        handlePressSuccess()
                    }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            handlePressStart()
                        }
                    }
                    .onEnded { _ in
                        if !isPressed || pressProgress < 1.0 {
                            handlePressCancel()
                        }
                    }
            )
            
            // Stats Display
            VStack(spacing: 12) {
                StatRow(label: "Success Count", value: "\(pressCount)")
                StatRow(
                    label: "Duration",
                    value: String(format: "%.2fs", pressDuration)
                )
            }
            .padding()
            .background(.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            // Instructions
            VStack(spacing: 4) {
                Text("Press and hold")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("for \(String(format: "%.1f", longPressDuration)) seconds")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // Reset Button
            Button {
                pressCount = 0
                pressDuration = 0.0
            } label: {
                Label("Reset", systemImage: "arrow.counterclockwise")
                    .font(.caption)
            }
            .buttonStyle(.bordered)
            .tint(.red)
            }
            .padding()
        }
        .navigationTitle("Long Press")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Methods
    
    private func handlePressStart() {
        isPressed = true
        pressDuration = 0.0
        pressProgress = 0.0
        
        // Start progress timer
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            pressDuration += 0.05
            pressProgress = min(pressDuration / longPressDuration, 1.0)
        }
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isPressed = true
        }
    }
    
    private func handlePressSuccess() {
        timer?.invalidate()
        pressCount += 1
        gestureService.recordGesture(.longPress, value: pressDuration)
        
        // Success animation
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            pressProgress = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = false
                pressProgress = 0.0
            }
        }
    }
    
    private func handlePressCancel() {
        timer?.invalidate()
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isPressed = false
            pressProgress = 0.0
            pressDuration = 0.0
        }
    }
}

#Preview {
    NavigationStack {
        LongPressDemoView()
    }
}
