//
//  DragGestureDemoView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct DragGestureDemoView: View {
    @State private var gestureService = GestureService.shared
    @State private var offset: CGSize = .zero
    @State private var dragDistance: Double = 0.0
    @State private var isDragging: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Spacer()
                
                // Draggable Element
                ZStack {
                    // Drag trail effect
                    if isDragging {
                        Circle()
                            .fill(.orange.opacity(0.2))
                            .frame(width: 80, height: 80)
                            .blur(radius: 10)
                    }
                    
                    // Main draggable circle
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.orange, .red],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image(systemName: "hand.draw")
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                        .shadow(color: .orange.opacity(0.5), radius: isDragging ? 12 : 6)
                        .scaleEffect(isDragging ? 1.1 : 1.0)
                }
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            let maxOffset: CGFloat = geometry.size.width / 3
                            let newX = min(max(value.translation.width, -maxOffset), maxOffset)
                            let newY = min(max(value.translation.height, -maxOffset), maxOffset)
                            offset = CGSize(width: newX, height: newY)
                            
                            let distance = sqrt(pow(newX, 2) + pow(newY, 2))
                            dragDistance = distance
                            gestureService.updateDragOffset(offset)
                        }
                        .onEnded { _ in
                            isDragging = false
                            gestureService.recordGesture(.drag, value: dragDistance)
                            
                            // Spring back to center
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                                offset = .zero
                                dragDistance = 0.0
                            }
                            gestureService.resetDragOffset()
                        }
                )
                
                Spacer()
                
                // Stats Display
                VStack(spacing: 8) {
                    HStack {
                        Text("Drag Distance")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.1f pts", dragDistance))
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("X Offset")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.1f", offset.width))
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Y Offset")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.1f", offset.height))
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Instructions
                Text("Drag the circle around")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .navigationTitle("Drag & Swipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DragGestureDemoView()
    }
}
