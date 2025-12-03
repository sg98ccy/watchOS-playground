//
//  HapticPatternsGalleryView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 3/12/25.
//

import SwiftUI

struct HapticPatternsGalleryView: View {
    @State private var hapticsService = HapticsService.shared
    @State private var selectedPattern: HapticPattern?
    
    var body: some View {
        List {
            ForEach(HapticPattern.allCases) { pattern in
                Button {
                    selectedPattern = pattern
                    hapticsService.play(pattern)
                } label: {
                    HStack(spacing: 12) {
                        // Icon
                        Image(systemName: pattern.icon)
                            .font(.title3)
                            .foregroundStyle(colorForPattern(pattern))
                            .frame(width: 30)
                        
                        // Pattern info
                        VStack(alignment: .leading, spacing: 2) {
                            Text(pattern.rawValue)
                                .font(.headline)
                            
                            Text(pattern.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        // Play indicator
                        if selectedPattern == pattern {
                            Image(systemName: "waveform")
                                .font(.caption)
                                .foregroundStyle(colorForPattern(pattern))
                                .symbolEffect(.pulse, options: .repeating)
                        }
                    }
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    selectedPattern == pattern
                        ? colorForPattern(pattern).opacity(0.15)
                        : Color.clear
                )
            }
        }
        .navigationTitle("Pattern Gallery")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Methods
    
    private func colorForPattern(_ pattern: HapticPattern) -> Color {
        switch pattern.color {
        case "blue": return .blue
        case "green": return .green
        case "orange": return .orange
        case "red": return .red
        case "yellow": return .yellow
        case "gray": return .gray
        default: return .primary
        }
    }
}

#Preview {
    NavigationStack {
        HapticPatternsGalleryView()
    }
}
