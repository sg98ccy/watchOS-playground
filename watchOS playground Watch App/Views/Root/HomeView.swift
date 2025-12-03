//
//  HomeView.swift
//  WatchOS Playground Watch App
//
//  Created by Chang Yue Chai on 2/12/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                // Sensors Lab - Active in Phase 1
                NavigationLink(destination: SensorsLabView()) {
                    LabRow(
                        icon: "waveform.path.ecg",
                        title: "Sensors Lab",
                        subtitle: "Motion & Accelerometer",
                        isEnabled: true
                    )
                }
                
                // Gestures Lab - Active in Phase 2
                NavigationLink(destination: GesturesLabView()) {
                    LabRow(
                        icon: "hand.tap",
                        title: "Gestures & Input",
                        subtitle: "Crown & Touch",
                        isEnabled: true
                    )
                }
                
                // Haptics Lab - Active in Phase 3
                NavigationLink(destination: HapticsLabView()) {
                    LabRow(
                        icon: "waveform",
                        title: "Haptics Lab",
                        subtitle: "Tactile Feedback",
                        isEnabled: true
                    )
                }
                
                // Health Lab - Active in Phase 4
                NavigationLink(destination: HealthLabView()) {
                    LabRow(
                        icon: "heart.fill",
                        title: "Health & Workout",
                        subtitle: "Heart Rate & Activity",
                        isEnabled: true
                    )
                }
                
                LabRow(
                    icon: "bell.fill",
                    title: "Notifications",
                    subtitle: "Alerts & Actions",
                    isEnabled: false
                )
                
                LabRow(
                    icon: "square.stack.fill",
                    title: "Widgets & Stack",
                    subtitle: "Smart Stack Demo",
                    isEnabled: false
                )
                
                LabRow(
                    icon: "network",
                    title: "Connectivity",
                    subtitle: "Network & Status",
                    isEnabled: false
                )
                
                LabRow(
                    icon: "info.circle",
                    title: "About",
                    subtitle: "Version & Diagnostics",
                    isEnabled: false
                )
            }
            .navigationTitle("WatchOS Labs")
        }
    }
}

// MARK: - Lab Row Component

struct LabRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let isEnabled: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(isEnabled ? .blue : .gray)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(isEnabled ? .primary : .secondary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if !isEnabled {
                Text("Soon")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(.secondary.opacity(0.2))
                    .clipShape(Capsule())
            }
        }
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}

#Preview {
    HomeView()
}
