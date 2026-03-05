<h1 align="center">watchOS playground</h1>

<p align="center">
  Native watchOS capability playground built with SwiftUI<br>
  Hands-on labs for sensors, gestures, haptics, and HealthKit workflows
</p>

<p align="center">
  <img src="watchOS playground Watch App/Assets.xcassets/demo-watch.imageset/demo-watch 1.png" alt="watchOS Playground banner" width="100%" />
</p>

---

## Overview

`watchOS playground` is a technical sandbox for exploring Apple Watch APIs through focused, interactive labs.
It is structured for fast experimentation with watch input patterns, sensor streams, tactile feedback, and health-related features.

## Implemented Labs

### Sensors Lab

- Live accelerometer readings across X/Y/Z axes
- Real-time motion visualizer that responds to wrist/device tilt
- Magnitude tracking and smooth streaming updates

### Gestures & Input Lab

- Digital Crown rotation demo (range tracking and reset)
- Single/double tap interactions
- Drag gesture tracking with spring-back behavior
- Long-press interaction with progress feedback
- Recent gesture history panel

### Haptics Lab

- Gallery of 9 haptic pattern types
- Pre-built haptic sequences for common UX flows
- Rhythm demo with BPM-based timing controls
- Session-level usage metrics

### Health & Workout Lab

- HealthKit authorization flow
- Simulated real-time heart rate updates
- Workout session controls for 6 workout types
- Duration and calorie estimates during sessions
- Health metric history and summary views

## Coming Soon

- Notifications Lab
- Widgets & Smart Stack Lab
- Connectivity Lab
- About & Diagnostics

## Architecture Snapshot

```text
watchOS playground Watch App/
├── ContentView.swift
├── WatchOS_PlaygroundApp.swift
├── Models/
│   ├── GestureType.swift
│   ├── HapticPattern.swift
│   ├── HealthMetric.swift
│   └── SensorSample.swift
├── Services/
│   ├── GestureService.swift
│   ├── HapticsService.swift
│   ├── HealthService.swift
│   └── MotionService.swift
└── Views/
    ├── Root/
    │   └── HomeView.swift
    └── Labs/
        ├── Sensors/
        ├── Gestures/
        ├── Haptics/
        └── Health/
```

### Design Approach

- **Models**: lightweight value types for app state
- **Services**: framework-facing logic (CoreMotion, WatchKit, HealthKit)
- **Views**: SwiftUI screens composed from focused lab experiences
- **Navigation**: centralized home hub routing to each lab

## Platform Requirements

- **watchOS**: 11.0+
- **Xcode**: 16.0+
- **Swift**: 5.9+
- **UI Framework**: SwiftUI

## Quick Start

### Prerequisites

- macOS with Xcode 16+
- Apple Watch Simulator or paired physical Apple Watch

### Run

```bash
git clone https://github.com/sg98ccy/WatchOS-Playground.git
cd "watchOS playground"
open "watchOS playground.xcodeproj"
```

In Xcode:

1. Select the `watchOS playground Watch App` scheme
2. Choose a watchOS simulator or a paired device target
3. Press `Cmd + R`

### Optional CLI Build

```bash
xcodebuild -project "watchOS playground.xcodeproj" -scheme "watchOS playground Watch App" -destination 'platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)'
```

## Tech Stack

- SwiftUI
- CoreMotion
- WatchKit
- HealthKit
- Combine

No third-party dependencies are required.

## Demo Notes

- Heart-rate values in the current health demo are simulated for interactive testing.
- Real haptic output is only available on physical Apple Watch hardware.
- Motion behavior is best validated on device, even though simulator iteration is supported.

## Contributing

Suggestions and improvements are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Changelog

Release history is tracked in [CHANGELOG.md](CHANGELOG.md).

## License

See [LICENSE](LICENSE).

## Resources

- [Apple Watch Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/watchos)
- [SwiftUI for watchOS](https://developer.apple.com/documentation/swiftui)
- [CoreMotion Documentation](https://developer.apple.com/documentation/coremotion)
- [WatchKit Documentation](https://developer.apple.com/documentation/watchkit)
- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
