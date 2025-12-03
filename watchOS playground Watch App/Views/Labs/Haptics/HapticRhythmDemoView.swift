//
//  HapticRhythmDemoView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HapticRhythmDemoView: View {
    @State private var hapticsService = HapticsService.shared
    @State private var isPlaying: Bool = false
    @State private var selectedBPM: Int = 60
    @State private var beatCount: Int = 4
    
    private let bpmOptions = [40, 60, 80, 100, 120]
    private let countOptions = [2, 4, 8, 16]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Visual Indicator
                ZStack {
                    Circle()
                        .stroke(.pink.opacity(0.3), lineWidth: 4)
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "metronome.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(isPlaying ? .pink : .gray)
                        .symbolEffect(.pulse, options: .repeating, isActive: isPlaying)
                }
                .padding(.top, 20)
                
                // BPM Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tempo (BPM)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 8) {
                        ForEach(bpmOptions, id: \.self) { bpm in
                            Button {
                                selectedBPM = bpm
                                hapticsService.playClick()
                            } label: {
                                Text("\(bpm)")
                                    .font(.caption)
                                    .fontWeight(selectedBPM == bpm ? .bold : .regular)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(selectedBPM == bpm ? Color.pink : Color.secondary.opacity(0.2))
                                    .foregroundStyle(selectedBPM == bpm ? .white : .primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Beat Count Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Beat Count")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 8) {
                        ForEach(countOptions, id: \.self) { count in
                            Button {
                                beatCount = count
                                hapticsService.playClick()
                            } label: {
                                Text("\(count)")
                                    .font(.caption)
                                    .fontWeight(beatCount == count ? .bold : .regular)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(beatCount == count ? Color.pink : Color.secondary.opacity(0.2))
                                    .foregroundStyle(beatCount == count ? .white : .primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Info Display
                VStack(spacing: 8) {
                    HStack {
                        Text("Duration")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.1fs", calculateDuration()))
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Interval")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.0fms", beatInterval * 1000))
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Play Button
                Button {
                    playRhythm()
                } label: {
                    HStack {
                        Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        Text(isPlaying ? "Playing..." : "Play Rhythm")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isPlaying ? Color.red : Color.pink)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .disabled(isPlaying)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Rhythm")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Computed Properties
    
    private var beatInterval: TimeInterval {
        60.0 / Double(selectedBPM)
    }
    
    // MARK: - Helper Methods
    
    private func calculateDuration() -> Double {
        return Double(beatCount) * beatInterval
    }
    
    private func playRhythm() {
        guard !isPlaying else { return }
        
        isPlaying = true
        
        // Play beats
        for i in 0..<beatCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + (beatInterval * Double(i))) {
                hapticsService.play(.click)
            }
        }
        
        // Reset playing state after completion
        DispatchQueue.main.asyncAfter(deadline: .now() + calculateDuration() + 0.2) {
            isPlaying = false
        }
    }
}

#Preview {
    NavigationStack {
        HapticRhythmDemoView()
    }
}
