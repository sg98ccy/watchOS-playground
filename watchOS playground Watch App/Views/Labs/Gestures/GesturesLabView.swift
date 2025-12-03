//
//  GesturesLabView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct GesturesLabView: View {
    @State private var gestureService = GestureService.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(spacing: 4) {
                    Image(systemName: "hand.tap")
                        .font(.largeTitle)
                        .foregroundStyle(.purple)
                    
                    Text("Gestures Lab")
                        .font(.headline)
                }
                .padding(.top, 8)
                
                // Digital Crown Demo
                NavigationLink(destination: DigitalCrownDemoView()) {
                    HStack {
                        Image(systemName: "digitalcrown.horizontal.arrow.counterclockwise")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Digital Crown")
                                .font(.headline)
                            Text("Rotation input")
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
                
                // Tap Gestures Demo
                NavigationLink(destination: TapGesturesDemoView()) {
                    HStack {
                        Image(systemName: "hand.tap")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Tap Gestures")
                                .font(.headline)
                            Text("Single & Double Tap")
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
                
                // Drag Gesture Demo
                NavigationLink(destination: DragGestureDemoView()) {
                    HStack {
                        Image(systemName: "hand.draw")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Drag & Swipe")
                                .font(.headline)
                            Text("Touch movement")
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
                
                // Long Press Demo
                NavigationLink(destination: LongPressDemoView()) {
                    HStack {
                        Image(systemName: "hand.tap.fill")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Long Press")
                                .font(.headline)
                            Text("Press and hold")
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
                
                // Recent Events
                if !gestureService.recentEvents.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundStyle(.secondary)
                            Text("Recent Gestures")
                                .font(.headline)
                            
                            Spacer()
                            
                            Button("Clear") {
                                gestureService.clearHistory()
                            }
                            .font(.caption)
                            .buttonStyle(.plain)
                            .foregroundStyle(.blue)
                        }
                        
                        Divider()
                        
                        ForEach(gestureService.recentEvents.prefix(5)) { event in
                            GestureEventRow(event: event)
                        }
                    }
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("Gestures")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Gesture Event Row

struct GestureEventRow: View {
    let event: GestureEvent
    
    var body: some View {
        HStack {
            Image(systemName: event.type.icon)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 20)
            
            Text(event.type.rawValue)
                .font(.caption)
            
            Spacer()
            
            if let value = event.value {
                Text(String(format: "%.2f", value))
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            
            Text(event.timestamp, style: .time)
                .font(.system(.caption2, design: .monospaced))
                .foregroundStyle(.tertiary)
        }
    }
}

#Preview {
    NavigationStack {
        GesturesLabView()
    }
}
