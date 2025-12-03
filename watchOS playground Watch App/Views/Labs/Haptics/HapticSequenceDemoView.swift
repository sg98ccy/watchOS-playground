//
//  HapticSequenceDemoView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HapticSequenceDemoView: View {
    @State private var hapticsService = HapticsService.shared
    @State private var isPlaying: Bool = false
    @State private var currentPatternIndex: Int = 0
    
    private let sequences: [(name: String, patterns: [HapticPattern], icon: String, color: Color)] = [
        (
            name: "Success Flow",
            patterns: [.start, .directionUp, .success],
            icon: "checkmark.circle.fill",
            color: .green
        ),
        (
            name: "Error Alert",
            patterns: [.notification, .failure, .retry],
            icon: "exclamationmark.triangle.fill",
            color: .red
        ),
        (
            name: "Navigation",
            patterns: [.click, .directionUp, .click],
            icon: "arrow.up.circle.fill",
            color: .blue
        ),
        (
            name: "Complete Task",
            patterns: [.start, .click, .click, .success],
            icon: "list.bullet.circle.fill",
            color: .purple
        ),
        (
            name: "Stop Action",
            patterns: [.directionDown, .stop],
            icon: "stop.circle.fill",
            color: .orange
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Instructions
                Text("Tap a sequence to feel it")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
                
                // Sequence Cards
                ForEach(Array(sequences.enumerated()), id: \.offset) { index, sequence in
                    SequenceCard(
                        name: sequence.name,
                        patterns: sequence.patterns,
                        icon: sequence.icon,
                        color: sequence.color,
                        isPlaying: isPlaying && currentPatternIndex == index
                    ) {
                        playSequence(at: index)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Sequences")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Methods
    
    private func playSequence(at index: Int) {
        guard !isPlaying else { return }
        
        isPlaying = true
        currentPatternIndex = index
        
        let sequence = sequences[index]
        hapticsService.playSequence(sequence.patterns, delay: 0.3)
        
        // Reset after sequence completes
        let duration = Double(sequence.patterns.count) * 0.3 + 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            isPlaying = false
        }
    }
}

// MARK: - Sequence Card Component

struct SequenceCard: View {
    let name: String
    let patterns: [HapticPattern]
    let icon: String
    let color: Color
    let isPlaying: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                // Header
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(color)
                    
                    Text(name)
                        .font(.headline)
                    
                    Spacer()
                    
                    if isPlaying {
                        ProgressView()
                            .tint(color)
                    } else {
                        Image(systemName: "play.fill")
                            .font(.caption)
                            .foregroundStyle(color)
                    }
                }
                
                // Pattern Preview
                HStack(spacing: 4) {
                    ForEach(Array(patterns.enumerated()), id: \.offset) { index, pattern in
                        Image(systemName: pattern.icon)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        
                        if index < patterns.count - 1 {
                            Image(systemName: "arrow.right")
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                    }
                }
                
                // Pattern Count
                Text("\(patterns.count) patterns • \(String(format: "%.1f", Double(patterns.count) * 0.3))s")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
        .disabled(isPlaying)
    }
}

#Preview {
    NavigationStack {
        HapticSequenceDemoView()
    }
}
