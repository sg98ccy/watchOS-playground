# WatchOS Playground

A native watchOS application designed to explore, demonstrate, and interact with core capabilities of Apple Watch.

## Platform Requirements

- **watchOS**: 11.0+
- **Xcode**: 16.0+
- **Swift**: 5.9+
- **Framework**: SwiftUI

## Project Overview

WatchOS Playground is a technical demonstration and learning environment for Apple Watch development, featuring multiple interactive labs that showcase various watchOS capabilities including motion sensors, gestures, haptics, health data, and more.

## Labs Explained

### What Each Lab Does

**Sensors Lab** - Motion & Accelerometer Testing

- **Purpose**: Test and visualize the Apple Watch's motion sensors (accelerometer and gyroscope)
- **Use Case**: Perfect for understanding device orientation, detecting movement patterns, and building motion-aware apps
- **Features**: Live accelerometer data (X/Y/Z axes), interactive motion visualizer that responds to wrist tilt

**Gestures & Input Lab** - Touch & Crown Interaction

- **Purpose**: Explore all input methods available on Apple Watch
- **Use Case**: Learn how to implement Digital Crown rotation, tap gestures, drag movements, and long press interactions
- **Features**: Digital Crown demo (-10 to +10 range), single/double tap detection, drag tracking, long press with progress visualization

**Haptics Lab** - Tactile Feedback Exploration

- **Purpose**: Experience and implement all haptic feedback types available on watchOS
- **Use Case**: Essential for adding tactile responses to user interactions and notifications
- **Features**: 9 haptic patterns gallery, pre-built sequences (success, error, navigation), rhythm generator with BPM control

**Health & Workout Lab** - HealthKit Integration

- **Purpose**: Interact with Apple Watch health sensors and workout tracking capabilities
- **Use Case**: Build fitness apps, monitor health metrics, and create workout experiences
- **Features**: Real-time heart rate monitoring, workout session tracking (6 workout types), health statistics with history, calorie burn calculation

**Notifications Lab** *(Coming Soon)*

- **Purpose**: Learn notification handling and user engagement patterns
- **Use Case**: Implement actionable notifications and test different notification styles

**Widgets & Smart Stack** *(Coming Soon)*

- **Purpose**: Create and test watchOS widgets and Smart Stack integration
- **Use Case**: Build glanceable information displays for the Smart Stack

**Connectivity Lab** *(Coming Soon)*

- **Purpose**: Test network requests and connectivity states
- **Use Case**: Handle offline scenarios and monitor connection status

**About & Diagnostics** *(Coming Soon)*

- **Purpose**: Display system information and debug tools
- **Use Case**: Monitor app performance and system metrics

## Current Status: Phase 4 Complete

**Version**: 0.4.0

### Completed Phases

- ✅ **Phase 1**: Sensors Lab - Motion tracking and visualization
- ✅ **Phase 2**: Gestures & Input Lab - All input methods
- ✅ **Phase 3**: Haptics Lab - Tactile feedback patterns
- ✅ **Phase 4**: Health & Workout Lab - HealthKit integration

### Active Features

- Real-time motion sensor visualization
- Comprehensive gesture detection (Crown, tap, drag, long press)
- Complete haptic feedback library with sequences
- Heart rate monitoring and workout tracking
- Clean, scalable architecture for future expansion

## Labs Roadmap

### ✅ Completed Labs

**Phase 1: Sensors Lab**

- Live accelerometer readings (X, Y, Z axes)
- Real-time motion visualizer with tilt response
- Magnitude calculation and tracking
- 60 Hz update rate

**Phase 2: Gestures & Input Lab**

- Digital Crown rotation tracking
- Single and double tap detection
- Drag gesture with spring-back animation
- Long press with progress visualization
- Gesture history tracking

**Phase 3: Haptics Lab**

- 9 haptic pattern types (notification, success, failure, etc.)
- Pre-built sequences for common flows
- Rhythm generator (40-120 BPM)
- Session statistics tracking

**Phase 4: Health & Workout Lab**

- Real-time heart rate monitoring
- 6 workout types (Walking, Running, Cycling, HIIT, Yoga, Strength)
- Workout duration and calorie tracking
- Health metrics history
- HealthKit authorization flow

### Future Labs

- **Phase 5: Notifications Lab** - Scheduled notifications with actions
- **Phase 6: Widgets & Smart Stack Lab** - Interactive widgets
- **Phase 7: Connectivity Lab** - Network requests and connection monitoring
- **Phase 8: About & Diagnostics** - Version info and system diagnostics

## Project Architecture

### Directory Structure

```
WatchOS Playground Watch App/
├── WatchOS_PlaygroundApp.swift
├── Models/
│   ├── SensorSample.swift
│   ├── GestureType.swift
│   ├── GestureEvent.swift
│   ├── HapticPattern.swift
│   ├── HealthMetric.swift
│   └── WorkoutType.swift
├── Services/
│   ├── MotionService.swift
│   ├── GestureService.swift
│   ├── HapticsService.swift
│   └── HealthService.swift
├── Views/
│   ├── Root/
│   │   ├── ContentView.swift
│   │   └── HomeView.swift
│   └── Labs/
│       ├── Sensors/
│       │   ├── SensorsLabView.swift
│       │   └── MotionVisualizerView.swift
│       ├── Gestures/
│       │   ├── GesturesLabView.swift
│       │   ├── DigitalCrownDemoView.swift
│       │   ├── TapGesturesDemoView.swift
│       │   ├── DragGestureDemoView.swift
│       │   └── LongPressDemoView.swift
│       ├── Haptics/
│       │   ├── HapticsLabView.swift
│       │   ├── HapticPatternsGalleryView.swift
│       │   ├── HapticSequenceDemoView.swift
│       │   └── HapticRhythmDemoView.swift
│       └── Health/
│           ├── HealthLabView.swift
│           ├── HeartRateMonitorView.swift
│           ├── WorkoutSessionView.swift
│           └── HealthStatsView.swift
└── Assets.xcassets/
```

### Architecture Pattern

The app follows a **MVVM-like architecture** with a clean separation of concerns:

**Models**: Pure data structures (structs, enums) representing application state
**Services**: Singleton managers encapsulating framework interactions (CoreMotion, HealthKit, WatchKit)
**Views**: SwiftUI views with no business logic, reactive to service state changes

### Core Services

**MotionService** (Phase 1)
- Wraps CoreMotion framework access
- Publishes real-time accelerometer data
- Manages sensor lifecycle and performance
- 60 Hz update rate for smooth visualization

**GestureService** (Phase 2)
- Tracks gesture events across the app
- Maintains history of last 10 gestures
- Provides type-safe gesture detection
- Handles Digital Crown, tap, drag, long press

**HapticsService** (Phase 3)
- Encapsulates WKInterfaceDevice haptic feedback
- Provides pattern gallery and sequences
- Generates rhythm patterns at specified BPM
- Tracks session statistics

**HealthService** (Phase 4)
- Manages HealthKit authorization and queries
- Simulates real-time heart rate monitoring
- Tracks workout sessions with duration and calories
- Stores health metrics history

### Views Organization

**Root Views**
- `HomeView`: Main navigation hub with all lab links
- `ContentView`: App root container

**Lab Hub Views**
- `SensorsLabView`: Sensor readings and visualizer link
- `GesturesLabView`: Gesture detection demos hub
- `HapticsLabView`: Haptic feedback patterns hub
- `HealthLabView`: Health monitoring and workouts hub

**Demo Views**
- Individual focused demos for each capability
- Self-contained, scrollable experiences
- Proper lifecycle management (onAppear/onDisappear)

## Setup & Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/sg98ccy/WatchOS-Playground.git
   cd "WatchOS Playground"
   ```

2. **Open in Xcode**

   ```bash
   open "WatchOS Playground.xcodeproj"
   ```

3. **Build and Run**

   - Select your Apple Watch or Watch Simulator as the target
   - Press `Cmd + R` to build and run

## Usage

### Running on Simulator

1. Select a Watch Simulator (Series 9 or later recommended)
2. Build and run the app
3. Use simulator's motion controls for testing

### Running on Device

1. Connect your Apple Watch via iPhone
2. Select your physical watch as the deployment target
3. Build and run to experience real motion tracking and health features

### Using the Labs

**Sensors Lab**

1. Launch the app and tap "Sensors Lab"
2. View live accelerometer readings (x, y, z axes)
3. Tap "Motion Visualizer" to see the interactive demo
4. Move your wrist to see the dot respond to tilt

**Gestures Lab**

1. Tap "Gestures Lab" from home
2. Explore Digital Crown rotation, tap gestures, drag, and long press
3. Each demo tracks and displays your interactions
4. History panel shows last 10 gestures

**Haptics Lab**

1. Tap "Haptics Lab" from home
2. Try different haptic patterns in the gallery
3. Play pre-built sequences for common UI flows
4. Use rhythm generator to create metronome-style feedback

**Health Lab**

1. Tap "Health Lab" from home
2. Grant HealthKit permissions when prompted
3. Monitor real-time heart rate (simulated 60-180 BPM)
4. Start workout sessions and track duration/calories
5. View health metrics history

## Dependencies

This project uses only native Apple frameworks:

- **SwiftUI**: UI framework
- **CoreMotion**: Motion and sensor access
- **WatchKit**: Haptic feedback and watch interface
- **HealthKit**: Health data and workout tracking
- **Combine**: Reactive data streaming (legacy support)

No external dependencies or package managers required.

## Development

### Building

```bash
xcodebuild -project "WatchOS Playground.xcodeproj" -scheme "WatchOS Playground Watch App" -destination 'platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)'
```

### Testing

- Run on simulator for quick iterations
- Test on physical device for accurate motion data and health features
- Verify battery and CPU usage during extended sessions
- Test haptic feedback on actual device (not available in simulator)

## Version History

### v0.4.0 (Current)

- **Phase 4**: Health & Workout Lab
  - Real-time heart rate monitoring
  - 6 workout types with tracking
  - Health metrics history
  - HealthKit integration

### v0.3.0

- **Phase 3**: Haptics Lab
  - 9 haptic pattern types
  - Pre-built sequences
  - Rhythm generator (40-120 BPM)

### v0.2.0

- **Phase 2**: Gestures & Input Lab
  - Digital Crown rotation tracking
  - Tap gestures (single/double)
  - Drag gesture with spring animation
  - Long press with progress

### v0.1.0

- **Phase 1**: Sensors Lab
  - Initial release
  - Complete Sensors Lab implementation
  - Foundation architecture for future labs
  - Motion visualizer with real-time tilt response

## Author

**Jackson Chai** ([@sg98ccy](https://github.com/sg98ccy))  
Created: December 2, 2025  
Repository: [WatchOS-Playground](https://github.com/sg98ccy/WatchOS-Playground)

## License

This is a personal learning project and playground for watchOS development.

## Contributing

This is a personal project, but suggestions and ideas are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details, or open an issue on [GitHub](https://github.com/sg98ccy/WatchOS-Playground/issues).

## Known Issues

None at this time.

## Resources

- [Apple Watch Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/watchos)
- [CoreMotion Documentation](https://developer.apple.com/documentation/coremotion)
- [WatchKit Framework](https://developer.apple.com/documentation/watchkit)
- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
- [SwiftUI for watchOS](https://developer.apple.com/documentation/swiftui)

---

**Note**: Phase 4 is complete with Sensors, Gestures, Haptics, and Health labs. Additional labs coming in future phases.
