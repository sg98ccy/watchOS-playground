//
//  HapticsLabView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HapticsLabView: View {
    @State private var hapticsService = HapticsService.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(spacing: 4) {
                    Image(systemName: "waveform")
                        .font(.largeTitle)
                        .foregroundStyle(.pink)
                    
                    Text("Haptics Lab")
                        .font(.headline)
                }
                .padding(.top, 8)
                
                // Haptic Patterns Gallery Link
                NavigationLink(destination: HapticPatternsGalleryView()) {
                    HStack {
                        Image(systemName: "square.grid.2x2.fill")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Pattern Gallery")
                                .font(.headline)
                            Text("All haptic types")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.pink.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                
                // Sequence Demo Link
                NavigationLink(destination: HapticSequenceDemoView()) {
                    HStack {
                        Image(systemName: "waveform.path")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Sequences")
                                .font(.headline)
                            Text("Pattern combinations")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.purple.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                
                // Rhythm Demo Link
                NavigationLink(destination: HapticRhythmDemoView()) {
                    HStack {
                        Image(systemName: "metronome.fill")
                            .font(.title3)
                        
                        VStack(alignment: .leading) {
                            Text("Rhythm")
                                .font(.headline)
                            Text("Timed patterns")
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
                
                // Stats Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                            .foregroundStyle(.secondary)
                        Text("Session Stats")
                            .font(.headline)
                    }
                    
                    Divider()
                    
                    StatRow(label: "Haptics Played", value: "\(hapticsService.hapticCount)")
                    
                    if let lastPattern = hapticsService.lastPattern {
                        HStack {
                            Text("Last Pattern")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: lastPattern.icon)
                                    .font(.caption)
                                Text(lastPattern.rawValue)
                                    .font(.caption)
                            }
                            .fontWeight(.semibold)
                        }
                    }
                    
                    HStack {
                        Text("Status")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Circle()
                                .fill(hapticsService.isEnabled ? .green : .gray)
                                .frame(width: 6, height: 6)
                            
                            Text(hapticsService.isEnabled ? "Enabled" : "Disabled")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Divider()
                    
                    // Controls
                    HStack(spacing: 8) {
                        Button {
                            hapticsService.toggleEnabled()
                            if hapticsService.isEnabled {
                                hapticsService.playClick()
                            }
                        } label: {
                            Label(
                                hapticsService.isEnabled ? "Disable" : "Enable",
                                systemImage: hapticsService.isEnabled ? "speaker.slash" : "speaker.wave.2"
                            )
                            .font(.caption)
                        }
                        .buttonStyle(.bordered)
                        .tint(hapticsService.isEnabled ? .red : .green)
                        
                        Button {
                            hapticsService.resetCount()
                        } label: {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                                .font(.caption)
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    }
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .navigationTitle("Haptics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HapticsLabView()
    }
}
