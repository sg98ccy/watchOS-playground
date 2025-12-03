# WatchOS Playground - Architecture Documentation

## Overview

WatchOS Playground is a native watchOS application built with SwiftUI to demonstrate and explore Apple Watch capabilities. This document provides technical details about the project structure and implementation.

## Tech Stack

- **Platform**: watchOS 11.0+
- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Architecture Pattern**: MVVM-like with Services
- **State Management**: @Observable macro (Swift 5.9)
- **Sensors**: CoreMotion framework

## Project Architecture

### Layer Separation

```
┌─────────────────────────────────────┐
│         Views (SwiftUI)             │
│  - HomeView                         │
│  - SensorsLabView                   │
│  - MotionVisualizerView             │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│      Services (Business Logic)      │
│  - MotionService                    │
│  - (Future: HealthService, etc.)    │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│       Models (Data Structures)      │
│  - SensorSample                     │
└─────────────────────────────────────┘
                 ↓
┌─────────────────────────────────────┐
│      System Frameworks              │
│  - CoreMotion                       │
│  - HealthKit (Future)               │
└─────────────────────────────────────┘
```

## Core Components

### Models

#### SensorSample
Represents a single motion sensor reading.

```swift
struct SensorSample {
    let timestamp: Date
    let x: Double  // Lateral acceleration
    let y: Double  // Vertical acceleration
    let z: Double  // Forward/backward acceleration
    var magnitude: Double { sqrt(x*x + y*y + z*z) }
}
```

**Purpose**: 
- Immutable data structure
- Provides computed properties
- Includes utility methods for normalization

### Services

#### MotionService
Singleton service managing CoreMotion interactions.

**Responsibilities**:
- Manage CMMotionManager lifecycle
- Publish real-time accelerometer data
- Handle sensor availability and errors
- Provide normalized data for UI consumption

**Key Features**:
- 60 Hz update rate for smooth animations
- Automatic start/stop based on view lifecycle
- Error state management
- Observable pattern for SwiftUI integration

**Thread Safety**: All updates occur on main queue via Timer

### Views

#### HomeView
Main navigation hub displaying available labs.

**Features**:
- NavigationStack for navigation management
- Lab cards with icons and descriptions
- Conditional styling for enabled/disabled labs
- Phase-based feature rollout

#### SensorsLabView
Displays real-time motion sensor data.

**Components**:
- Live accelerometer readings (X, Y, Z axes)
- Visual progress bars with center-zero alignment
- Magnitude calculation
- Color-coded axes (red, green, blue)
- Tracking status indicator
- Link to Motion Visualizer

**Performance Considerations**:
- Efficient SwiftUI updates via @Observable
- Lightweight view hierarchy
- Optimized refresh rate

#### MotionVisualizerView
Interactive visualization of device tilt.

**Features**:
- Animated dot responding to wrist movement
- Spring animations for natural feel
- Grid overlay for spatial reference
- Real-time data display
- Gradient effects and glow

**Animation Details**:
- Spring response: 0.3 seconds
- Damping fraction: 0.7
- Smooth interpolation between values

## Data Flow

```
1. User opens app
   └─> HomeView displayed

2. User taps "Sensors Lab"
   └─> SensorsLabView appears
       └─> onAppear() calls motionService.startTracking()
           └─> CMMotionManager starts accelerometer updates
               └─> Timer fires at 60 Hz
                   └─> currentSample updated
                       └─> SwiftUI automatically refreshes view

3. User navigates away
   └─> onDisappear() calls motionService.stopTracking()
       └─> Timer invalidated
       └─> CMMotionManager stops updates
```

## State Management

### @Observable Macro (Swift 5.9+)

The project uses the modern `@Observable` macro for state management, which provides:
- Automatic change tracking
- Fine-grained updates
- Better performance than `@ObservableObject`
- Cleaner syntax

Example:
```swift
@Observable
class MotionService {
    var currentSample: SensorSample = .placeholder
    var isTracking: Bool = false
}
```

Views automatically update when these properties change.

## Performance Optimization

### Sensor Updates
- **Update Rate**: 60 Hz (every ~16.7ms)
- **Reason**: Balances smooth animation with battery life
- **Alternative**: 100 Hz for more precision, 30 Hz for efficiency

### View Updates
- SwiftUI's diff algorithm minimizes actual UI updates
- Only changed properties trigger redraws
- Animations use GPU acceleration

### Battery Considerations
- Motion tracking stopped when views disappear
- No background processing
- Efficient Timer usage instead of continuous polling

## Future Expansion Points

### Adding New Labs

1. Create new folder in `Views/Labs/`
2. Implement service layer if needed
3. Add models for data structures
4. Update HomeView with navigation link
5. Test on device and simulator

### Adding New Services

1. Create service class with @Observable
2. Implement lifecycle methods
3. Add error handling
4. Provide public API for views
5. Consider singleton pattern for shared state

## Testing Strategy

### Simulator Testing
- Rapid iteration
- UI layout verification
- Basic functionality checks
- Limitations: Simulated sensor data only

### Device Testing
- Real motion data
- Performance validation
- Battery impact measurement
- Haptic feedback (when implemented)
- True user experience

## Build Configuration

### Debug
- Full symbol information
- Optimization disabled
- Development team signing

### Release
- Optimized for performance
- Reduced binary size
- Stripped debug symbols

## Dependencies

Currently: **NONE**

All functionality uses Apple's native frameworks:
- SwiftUI
- CoreMotion
- Foundation
- Combine (minimal use)

**Future**: May add Swift packages for specific needs

## Known Limitations

### Phase 1
- Accelerometer only (no gyroscope yet)
- No step counting yet
- No shake detection yet
- Simulator has limited motion simulation

## Code Quality Tools

Recommended:
- SwiftLint for style consistency
- SwiftFormat for automatic formatting
- Instruments for performance profiling

## Version Control Strategy

### Branching
- `main`: Stable releases only
- `develop`: Integration branch
- `feature/phase-X`: Individual phase work

### Commit Convention
```
type(scope): description

Examples:
feat(sensors): add motion visualizer
fix(ui): correct axis color coding
docs(readme): update installation steps
```

### Tags
- `v0.1.0-phase1-sensors-lab`
- `v0.2.0-phase2-gestures-lab`
- etc.

## Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [CoreMotion Guide](https://developer.apple.com/documentation/coremotion)
- [watchOS HIG](https://developer.apple.com/design/human-interface-guidelines/watchos)
- [Observable Macro](https://developer.apple.com/documentation/observation)

---

**Last Updated**: December 2, 2025  
**Current Phase**: Phase 1 - Sensors Lab  
**Maintainer**: Jackson Chai
